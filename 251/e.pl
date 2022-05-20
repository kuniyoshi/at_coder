#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp;
$dp[0][0][0] = 0;
$dp[0][0][1] = undef;
$dp[0][1][0] = undef;
$dp[0][1][1] = 0;

for my $i ( 1 .. $n ) {
    for my $j ( 0, 1 ) {
        for my $k ( 0, 1 ) {
            if ( $j ) {
                $dp[ $i ][ $j ][ $k ] = min( grep { defined } ( $dp[ $i - 1 ][0][ $k ], $dp[ $i - 1 ][1][ $k ] ) ) + $a[ $i - 1 ];
            }
            else {
                $dp[ $i ][ $j ][ $k ] = $dp[ $i - 1 ][1][ $k ];
            }
        }
    }
}

say min( $dp[ $n ][0][0], $dp[ $n ][1][1] );

exit;
