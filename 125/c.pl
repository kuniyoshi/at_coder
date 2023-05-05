#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @primes = list_primes( );
my @cds;
expand( $a[ $_ ] , ( $cds[ $_ ] = { } ) )
    for 0 .. $#a;

my $result = 1;
my $worked;

for my $prime ( reverse @primes ) {
    my $owners = 0;
    for my $i ( 0 .. $#a ) {
        $owners++
            if $cds[ $i ]{ $prime };
    }
    if ( !$worked && $owners == $n - 1 ) {
        $worked++;
        $result *= $prime;
        next;
    }
    if ( $owners == $n ) {
        $result *= $prime ** min( map { $_->{ $prime } } @cds );
    }
}

say $result;

exit;

sub expand {
    my $v = shift;
    my $ref = shift;
    for my $prime ( @primes ) {
        return
            if $prime > $v;
        while ( $v % $prime == 0 ) {
            $ref->{ $prime }++;
            $v /= $prime;
        }
    }
}

sub list_primes {
    my $max = int( sqrt( 1e9 ) );
    my @is_prime = ( 1 ) x ( $max + 1 );

    $is_prime[0] = 0;
    $is_prime[1] = 0;

    my @primes;

    for my $i ( 2 .. $#is_prime ) {
        next
            unless $is_prime[ $i ];
        push @primes, $i;
        for ( my $j = $i + $i; $j <= @is_prime; $j += $i ) {
            $is_prime[ $j ] = 0;
        }
    }

    return @primes;
}
