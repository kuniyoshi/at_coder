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

my @dp = map { [ ( undef ) x $w ] } 1 .. $h;
$dp[0][0] = 0;

for my $i ( 0 .. $h - 1 ) {
    for my $j ( 0 .. $w - 1 ) {
        next
            unless defined $dp[ $i ][ $j ];

        for my $p ( map { $_->add_xy( $j, $i ) } @moves ) {
            next
                unless $p->is_in;
            next
                unless $s[ $p->y ][ $p->x ] eq q{.};
            $dp[ $p->y ][ $p->x ] //= $dp[ $i ][ $j ] + 1;
            $dp[ $p->y ][ $p->x ] = min( $dp[ $p->y ][ $p->x ], $dp[ $i ][ $j ] + 1 );
        }
    }
}

my $cost = $dp[ $h - 1 ][ $w - 1 ];

if ( !defined $cost ) {
    say -1;
    exit;
}

my $whites = grep { $_ eq q{.} } map { @{ $_ } } @s;
say $whites - $cost - 1;

#my $count = 1;
#my $cursor = Vector2->new( $w - 1, $h - 1 );
#
#while ( !$cursor->is_origin ) {
#    my( $moved ) = grep { defined $dp[ $_->y ][ $_->x ] && $dp[ $_->y ][ $_->x ] == $dp[ $cursor->y ][ $cursor->x ] - 1 }
#                   grep { $_->is_in }
#                   map { $_->add_other( $cursor ) }
#                   @moves;
#    die "No move found from: ", $cursor->dump
#        unless $moved;
#    $cursor = $moved;
#    $count++;
#}
#
#my $whites = grep { $_ eq q{.} } map { @{ $_ } } @s;
#
#say $whites - $count;

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
