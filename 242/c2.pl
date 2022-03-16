#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MOD = 998244353;

chomp( my $n = <> );

my @dp;
$dp[0][ $_ ] = 1
    for 0 .. 8;

for my $i ( 1 .. ( $n - 1 ) ) {
    for my $j ( 1 .. 9 ) {
        if ( $j == 1 ) {
            $dp[ $i ][ $j - 1 ] = ( $dp[ $i - 1 ][0] + $dp[ $i - 1 ][1] ) % $MOD;
        }
        elsif ( $j == 9 ) {
            $dp[ $i ][ $j - 1 ] = ( $dp[ $i - 1 ][7] + $dp[ $i - 1 ][8] ) % $MOD;
        }
        else {
            $dp[ $i ][ $j - 1 ] = ( $dp[ $i - 1 ][ $j - 2 ] + $dp[ $i - 1 ][ $j - 1 ] + $dp[ $i - 1 ][ $j ] ) % $MOD;
        }
    }
}

my $answer = 0;

for my $i ( 0 .. 8 ) {
    $answer = ( $answer + $dp[ $n - 1 ][ $i ] ) % $MOD;
}

say $answer;

exit;
