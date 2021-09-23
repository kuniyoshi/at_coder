#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $xy = <> );
#my @bentos = map { [ split m{\s} ] }
#             map { chomp( my $l = <> ); $l }
#             1 .. $n;

my( $x, $y ) = split m{\s}, $xy;
my @dp = ( );

$dp[ $n * 300 * 300 + $x * 300 + $y ] = undef;

$dp[0] = 0;

my $MAX = 300;
my $MAXMAX = $MAX * $MAX;

for my $i ( 1 .. $n ) {
    chomp( my $line = <> );
    my( $cx, $cy ) = split m{\s}, $line;

    if ( !defined $dp[ ( $i - 1 ) * $MAXMAX ] ) {
        ;
    }
    elsif ( !defined $dp[ $i * $MAXMAX ] ) {
        $dp[ $i * $MAXMAX ] = $dp[ ( $i - 1 ) * $MAXMAX ];
    }
    else {
        $dp[ $i * $MAXMAX ] = $dp[ $i * $MAXMAX ] < $dp[ ( $i - 1 ) * $MAXMAX ] ? $dp[ $i * $MAXMAX ] : $dp[ ( $i - 1 ) * $MAXMAX ];
    }

    for my $j ( 0 .. $x ) {
        for my $k ( 0 .. $y ) {
            my $nx = $cx + $j < $x ? $cx + $j : $x;
            my $ny = $cy + $k < $y ? $cy + $k : $y;
            my $index_n = $i * $MAXMAX + $nx * $MAX + $ny;
            my $index_i = $i * $MAXMAX + $j * $MAX + $k;
            my $index_i_n1 = ( $i - 1 ) * $MAXMAX + $j * $MAX + $k;

            if ( !defined $dp[ $index_i ] && !defined $dp[ $index_i_n1 ] ) {
                ;
            }
            elsif ( !defined $dp[ $index_i ] ) {
                $dp[ $index_i ] = $dp[ $index_i_n1 ] + 1;
            }
            elsif ( !defined $dp[ $index_i_n1 ] ) {
                ;
            }
            else {
                $dp[ $index_i ] = $dp[ $index_i ] < $dp[ $index_i_n1 ] + 1
                    ? $dp[ $index_i ] : $dp[ $index_i_n1 ] + 1;
            }
        }
    }
}

say defined $dp[ $n * $MAXMAX + $x * $MAX + $y ]
    ? $dp[ $n * $MAXMAX + $x * $MAX + $y ]
    : -1;

exit;
