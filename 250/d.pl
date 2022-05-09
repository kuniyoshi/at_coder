#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MAX = 1e6;
my $SUB_MAX = 1e3;

chomp( my $n = <> );

my @primes = primes( );

my $count = 0;

for my $i ( 0 .. $#primes ) {
    last
        if 2 * $primes[ $i ] * $primes[ $i ] * $primes[ $i ] > $n;

    for my $j ( 0 .. $i - 1 ) {
        last
            if $primes[ $j ] * $primes[ $i ] * $primes[ $i ] * $primes[ $i ] > $n;
        $count++;
    }
}

say $count;

exit;

sub primes {
    my @results;

    my @furui = ( 1 ) x $MAX;
    $furui[0] = 0;
    $furui[1] = 0;

    for my $i ( 0 .. $SUB_MAX + 1 ) {
        next
            unless $furui[ $i ];

        for ( my $j = $i * $i; $j < $MAX; $j += $i ) {
            $furui[ $j ] = 0;
        }
    }

    return grep { $furui[ $_ ] } 0 .. $#furui;
}
