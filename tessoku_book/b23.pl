#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $n = <> );
my @xy = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $n;

my %distance;

for ( my $i = 0; $i < $n; ++$i ) {
    for ( my $j = 0; $j < $n; ++$j ) {
        $distance{ $i }{ $j } = sqrt( ( $xy[ $j ][0] - $xy[ $i ][0] ) ** 2 + ( $xy[ $j ][1] - $xy[ $i ][1] ) ** 2 );
    }
}

my @dp;
$dp[0][0] = 0;

for ( my $i = 0; $i < 2 ** $n; ++$i ) {
    for ( my $j = 0; $j < $n; ++$j ) {
        next
            unless defined $dp[ $i ][ $j ];

        for ( my $k = 0; $k < $n; ++$k ) {
            next
                if $k == $j;

            if ( !defined $dp[ $i | 1 << $j ][ $k ] ) {
                $dp[ $i | 1 << $j ][ $k ] = $dp[ $i ][ $j ] + $distance{ $j }{ $k };
            }
            else {
                $dp[ $i | 1 << $j ][ $k ] = min(
                    $dp[ $i | 1 << $j ][ $k ],
                    $dp[ $i ][ $j ] + $distance{ $j }{ $k },
                );
            }
        }
    }
}

say $dp[ ( 1 << $n ) - 1 ][0];

exit;

