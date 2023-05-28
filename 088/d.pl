#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

$Vector2::width = $w;
$Vector2::height = $h;

my @moves = (
    Vector2->new( 1, 0 ),
    Vector2->new( 0, 1 ),
    Vector2->new( -1, 0 ),
    Vector2->new( 0, -1 ),
);

my %distance;

my @queue = ( [ Vector2->new( 0, 0 ), 0 ] );

while ( @queue ) {
    my $ref = shift @queue;
    my( $p, $d ) = @{ $ref };
    next
        if defined $distance{ $p->x }{ $p->y };
    $distance{ $p->x }{ $p->y } = $d;
    push @queue, map { [ $_, $d + 1 ] }
                 grep { $_->is_in && $s[ $_->y ][ $_->x ] eq q{.} && !defined $distance{ $_->x }{ $_->y } }
                 map { $p->add_other( $_ ) }
                 @moves;
}

my $cost = $distance{ $w - 1 }{ $h - 1 };

if ( !defined $cost ) {
    say -1;
    exit;
}

my $whites = grep { $_ eq q{.} } map { @{ $_ } } @s;
say $whites - $cost - 1;

exit;

package Vector2 {
    our $width;
    our $height;

    sub new {
        my $class = shift;
        my $x = shift // 0;
        my $y = shift // 0;
        return bless [ $x, $y ], $class;
    }

    sub dump {
        my $self = shift;
        return "($self->[0], $self->[1])";
    }

    sub is_origin {
        my $self = shift;
        return $self->[0] == 0 && $self->[1] == 0;
    }

    sub addition {
        my $a = shift;
        my $b = shift;
        return Vector2->new( $a->[0] + $b->[0], $a->[1] + $b->[1] );
    }

    sub add_other {
        my $self = shift;
        my $other = shift;
        return Vector2->new( $self->[0] + $other->[0], $self->[1] + $other->[1] );
    }

    sub add_xy {
        my $self = shift;
        return Vector2->new( $self->[0] + shift, $self->[1] + shift );
    }

    sub y {
        shift->[1];
    }

    sub x {
        shift->[0];
    }

    sub is_in {
        my $self = shift;
        die "No width or height set"
            if !defined $width || !defined $height;
        return $self->[0] >= 0 && $self->[0] < $width && $self->[1] >= 0 && $self->[1] < $height;
    }
}
