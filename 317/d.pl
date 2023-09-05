#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max sum );

chomp( my $n = <> );
my @xyz = map { chomp; [ split m{\s} ] }
          map { scalar <> }
          1 .. $n;

my @costs = map { max( 0, int( ( $_->[1] - $_->[0] + 1 ) / 2 ) ) }
            @xyz;
my @seats = map { $_->[2] }
            @xyz;

my $total = sum( @seats );
my @dp = ( 0 );

for ( my $i = 0; $i < $n; ++$i ) {
    for ( my $j = $total; $j >= 0; --$j ) {
        next
            unless defined $dp[ $j ];
        $dp[ $j + $seats[ $i ] ] = min(
            $dp[ $j + $seats[ $i ] ] // $dp[ $j ] + $costs[ $i ],
            $dp[ $j ] + $costs[ $i ],
        );

    }
}

say min( grep { defined } @dp[ ( ( $total + 1 ) / 2 ) .. $total ] );

exit;
