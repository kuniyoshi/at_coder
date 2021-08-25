#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

#my $n = 100_000;
my $n = 100;

my @is_prime = ( 1 ) x $n;

$is_prime[0] = 0;
$is_prime[1] = 0;

for ( my $i = 2; $i < $n; ++$i ) {
    for ( my $j = 2 * $i; $j < $n; $j += $i ) {
        $is_prime[$j] = 0;
    }
}

say for grep { $is_prime[ $_ ] } ( 0 .. $#is_prime );
