#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @c = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

my @dp;

for ( my $i = $h - 1; $i >= 0; --$i ) {
    for ( my $j = $w - 1; $j >= 0; --$j ) {
        if ( $c[ $i ][ $j ] eq q{#} ) {
            $dp[ $i ][ $j ] = 0;
            next;
        }

        my $down = $dp[ $i + 1 ][ $j ] // 0;
        my $right = $dp[ $i ][ $j + 1 ] // 0;
        my $larger = $down > $right ? $down : $right;
        $dp[ $i ][ $j ] = $larger + 1;
    }
}

say $dp[0][0];

exit;

