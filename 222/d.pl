#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum max );

chomp( my $n = <> );
chomp( my $line_a = <> );
chomp( my $line_b = <> );
my @a = ( 0, split m{\s}, $line_a );
my @b = ( 0, split m{\s}, $line_b );

my $m = max( @b );

my @dp;
$dp[ $_ ] = [ ( 0 ) x ( $m + 1 ) ]
    for 0 .. $n;
$dp[0][ $_ ] = 1
    for 0 .. $m;

for my $i ( 1 .. $n ) {
    if ( is_in( 0, $a[ $i ], $b[ $i ] ) ) {
        $dp[ $i ][0] = $dp[ $i - 1 ][0];
    }
    else {
        $dp[ $i ][0] = 0;
    }

    for my $j ( 1 .. $m ) {
        if ( is_in( $j, $a[ $i ], $b[ $i ] ) ) {
            $dp[ $i ][ $j ] = ( $dp[ $i - 1 ][ $j ] + $dp[ $i ][ $j - 1 ] ) % 998244353;
        }
        else {
            $dp[ $i ][ $j ] = $dp[ $i ][ $j - 1 ];
        }
    }
}

say $dp[ $n ][ $m ];

exit;

sub is_in {
    my $target = shift;
    my $min = shift;
    my $max = shift;
    return $target >= $min && $target <= $max;
}
