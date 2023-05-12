#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );

my @primes = primes( 3e5 );

my $result = 0;

for my $a ( @primes ) {
    last
        if $a * $a * $a * $a * $a > $n;
    for my $b ( @primes ) {
        next
            if $b <= $a;
        last
            if $a * $a * $b * $b * $b > $n;

        for my $c ( @primes ) {
            next
                if $c <= $b;
            last
                if $a * $a * $b * $c * $c > $n;
            $result++;
        }
    }
}

say $result;

exit;

sub primes {
    my $max = shift;
    my @is_prime = ( 1 ) x ( $max + 1 );
    $is_prime[0] = 0;
    $is_prime[1] = 0;
    for my $i ( 0 .. sqrt( $max ) ) {
        next
            unless $is_prime[ $i ];
        for ( my $j = 2 * $i; $j <= $max; $j += $i ) {
            $is_prime[ $j ] = 0;
        }
    }
    return grep { $is_prime[ $_ ] } 2 .. $max;
}
