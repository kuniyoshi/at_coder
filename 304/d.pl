#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $n = <> );
my @strawberries = map { chomp; [ split m{\s} ] }
                   map { scalar <> }
                   1 .. $n;
chomp( my $a = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $b = <> );
my @b = do { chomp( my $l = <> ); split m{\s}, $l };

unshift @a, 0;
push @a, $w;

unshift @b, 0;
push @b, $h;

my %count;

for my $ref ( @strawberries ) {
    my( $bx, $by ) = @{ $ref };
    my $x = bin( $bx, \@a );
    my $y = bin( $by, \@b );
    $count{ "$x:$y" }++;
}

my $min = $n;
my $max = 0;

for my $count ( values %count ) {
    $min = min( $min, $count );
    $max = max( $max, $count );
}

$min = 0
    if %count < ( $a + 1 ) * ( $b + 1 );

say join q{ }, $min, $max;


exit;

sub bin {
    my $value = shift;
    my $ref = shift;

    my $ac = 0;
    my $wa = $#{ $ref };

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $ref->[ $wj ] <= $value ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    return $ref->[ $ac ];
}
