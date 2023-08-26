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
        $distance{ $i }{ $j } = ( $xy[ $j ][0] - $xy[ $i ][0] ) ** 2 + ( $xy[ $j ][1] - $xy[ $i ][1] ) ** 2;
    }
}

my @dp = ( 0 );

for ( my $i = 0; $i < $n; ++$i ) {
    $dp[ 1 << $i ] = 0;

    for ( my $j = 0; $j < 1 << $n; ++$j ) {
        next
            if !defined $dp[ $j ];

        if ( !defined $dp[ $j | ( 1 << $i ) ] ) {
            $dp[ $j | ( 1 << $i ) ] = $dp[ $j ] + min_distance( $j, $i );
        }
        else {
            $dp[ $j | ( 1 << $i ) ] = min( $dp[ $j | ( 1 << $i ) ], $dp[ $j ] + min_distance( $j, $i ) );
        }
    }
}


exit;
