#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );

my @is_primes = ( 1 ) x ( $n + 1 );

@is_primes[0] = 0;
@is_primes[1] = 0;

for ( my $i = 2; $i <= $n; ++$i ) {
    next
        unless $is_primes[ $i ];

    for ( my $j = 2 * $i; $j <= $n; $j += $i ) {
        $is_primes[ $j ] = 0;
    }
}

print map { $_, "\n" } grep { $is_primes[ $_ ] } 2 .. $n;

exit;
