#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @x = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $m;

my %bonus;

for my $ref ( @b ) {
    $bonus{ $ref->[0] } = $ref->[1];
}

my @dp;

for my $i ( 0 .. $n - 1 )  {
    for my $j ( 0 .. $i ) {
        for my $k ( 0, 1 ) {
            if ( $k ) {
                my $current = $dp[ $i ][ $j ][ $k ] // 0;
                my $bonus = $bonus{ $j + 1 } // 0;
                my $total = $current + $x[ $i ] + $bonus;
                $dp[ $i + 1 ][ $j + 1 ][ 0 ] = max( $dp[ $i + 1 ][ $j + 1 ][0] // 0, $total );
                $dp[ $i + 1 ][ $j + 1 ][ 1 ] = max( $dp[ $i + 1 ][ $j + 1 ][1] // 0, $total );
            }
            else {
                my $total = $dp[ $i ][ $j ][ $k ] // 0;
                $dp[ $i + 1 ][0][0] = max( $dp[ $i + 1 ][0][0] // 0, $total );
                $dp[ $i + 1 ][0][1] = max( $dp[ $i + 1 ][0][1] // 0, $total );
            }
        }
    }
}

my $max = 0;

for my $ref ( @dp ) {
    for my $ref2 ( @{ $ref } ) {
        for my $value ( @{ $ref2 } ) {
            $max = max( $max, $value );
        }
    }
}

say $max;

exit;
