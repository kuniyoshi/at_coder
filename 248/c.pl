#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum min max );

my $MOD = 998244353;

my( $n, $m, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp;

for my $i ( 0 .. $n ) {
    for my $j ( 0 .. $k ) {
        $dp[ $i ][ $j ] = 0;
    }
}

for my $i ( 1 .. $k ) {
    next
        unless $i <= $m;
    $dp[ 1 ][ $i ] = 1;
}

for my $i ( 2 .. $n ) {
    for my $j ( 1 .. $k ) {
        my $from = max( $j - $m, 1 );
        my $to = $j;
        $dp[ $i ][ $j ] = sum( @{ $dp[ $i - 1 ] }[ $from .. ( $to - 1 ) ] ) // 0;
        $dp[ $i ][ $j ] = $dp[ $i ][ $j ] % $MOD;
    }
}

say sum( @{ $dp[ $n ] } ) % $MOD;

exit;
