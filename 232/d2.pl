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

unshift @c, [ ( q{#} ) x ( $w + 1 ) ];
unshift @{ $_ }, q{#}
    for @c;

my @dp;

for ( my $i = 1; $i <= $h; ++$i ) {
    for ( my $j = 1; $j <= $w; ++$j ) {
        if ( $i == 1 && $j == 1 ) {
            $dp[1][1] = 1;
            next;
        }
        my $up = $c[ $i - 1 ][ $j ] eq q{.}
            ? ( ( $dp[ $i - 1 ][ $j ] // 0 ) + !!( $c[ $i ][ $j ] eq q{.} ) )
            : ( $dp[ $i - 1 ][ $j ] // 0 );
        my $left = $c[ $i ][ $j - 1 ] eq q{.}
            ? ( ( $dp[ $i ][ $j - 1 ] // 0 ) + !!( $c[ $i ][ $j ] eq q{.} ) )
            : ( $dp[ $i ][ $j - 1 ] // 0 );
        $dp[ $i ][ $j ] = $up > $left ? $up : $left;
    }
}

say $dp[ $h ][ $w ];

exit;

