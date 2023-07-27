#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my @s = do { chomp( my $l = <> ); split m{}, $l };
my @t = do { chomp( my $l = <> ); split m{}, $l };

my @dp = map { [ ( @s + @t ) x ( @t + 1 ) ] } 0 .. @s;
$dp[0][0] = 0;

for ( my $i = 0; $i <= @s; ++$i ) {
    for ( my $j = 0; $j <= @t; ++$j ) {
        next
            if $j == 0 && $i == 0;
        if ( $i == 0 ) {
            $dp[ $i ][ $j ] = $dp[ $i ][ $j - 1 ] + 1;
            next;
        }
        if ( $j == 0 ) {
            $dp[ $i ][ $j ] = $dp[ $i - 1 ][ $j ] + 1;
            next;
        }
        $dp[ $i ][ $j ] = min(
            $dp[ $i - 1 ][ $j ] + 1,
            $dp[ $i ][ $j - 1 ] + 1,
            ( $t[ $j - 1 ] eq $s[ $i - 1 ] ? $dp[ $i - 1 ][ $j - 1 ] : $dp[ $i - 1 ][ $j - 1 ] + 1 ),
        );
    }
}

#warn Dumper \@dp;

say $dp[ scalar @s ][ scalar @t ];

exit;
