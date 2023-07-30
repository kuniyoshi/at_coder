#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MOD = 998244353;

my( $h, $w, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my( $x1, $y1, $x2, $y2 ) = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp = ( 0 ) x 4;

my $index = ( $x1 != $x2 ) << 1 | ( $y1 != $y2 ) << 0;
$dp[ $index ] = 1;

for ( my $i = 1; $i <= $k; ++$i ) {
    my @values = @dp;
    $dp[0] = $values[1] + $values[2];
    $dp[1] = ( $w - 1 ) * $values[0] + ( $w - 2 ) * $values[1] + $values[3];
    $dp[2] = ( $h - 1 ) * $values[0] + ( $h - 2 ) * $values[2] + $values[3];
    $dp[3] = ( $h - 1 ) * $values[1] + ( $w - 1 ) * $values[2] + ( $h - 2 + $w - 2 ) * $values[3];
    $_ %= $MOD
        for @dp;
}

say $dp[0];

exit;
