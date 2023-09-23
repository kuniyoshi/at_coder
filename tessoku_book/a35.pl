#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max min );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp;
$dp[ $n - 1 ] = \@a;

for ( my $i = $n - 2; $i >= 0; --$i ) {
    for ( my $j = 0; $j < @{ $dp[ $i + 1 ] } - 1; ++$j ) {
        $dp[ $i ][ $j ] = $i % 2
            ? min( @{ $dp[ $i + 1 ] }[ $j, $j + 1 ] )
            : max( @{ $dp[ $i + 1 ] }[ $j, $j + 1 ] );
    }
}

say $dp[0][0];

exit;
