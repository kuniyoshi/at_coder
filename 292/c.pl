#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Memoize;

chomp( my $n = <> );

my %divisors;

for my $i ( 1 .. $n ) {
    my $count = 0;
    for my $j ( 1 .. sqrt( $i ) ) {
        next
            if $i % $j;
        $count++;
        $count++
            if $i / $j != $j;
    }
    $divisors{ $i } = $count;
}

my $count = 0;

for my $ab ( 1 .. $n - 1 ) {
    my $cd = $n - $ab;
    $count += $divisors{ $ab } * $divisors{ $cd };
}

say $count;

exit;
