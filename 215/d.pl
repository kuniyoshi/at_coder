#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Memoize;

memoize( "get_primes" );

my @PRIMES = ( );
my $MAX_PRIME = 0;

chomp( my $head_line = <> );
chomp( my $body_line = <> );
my( $n, $m ) = split m{\s}, $head_line;
my @a = split m{\s}, $body_line;

my @result = ( 1 ) x ( $m + 1 );
$result[0] = 0;

for my $a ( @a ) {
    my @prime_factors = get_prime_factors( $a );

    for my $prime_factor ( @prime_factors ) {
        next
            unless $result[ $prime_factor ];

        for ( my $i = $prime_factor; $i <= @result; $i += $prime_factor ) {
            $result[ $i ] = 0
        }
    }
}

say scalar grep { $_ } @result;
say
    for grep { $result[ $_ ] }
        ( 1 .. $#result );

exit;

sub get_prime_factors {
    my $value = shift;

    return ( )
        if $value < 2;

    my $n = $value;
    my @results = ( );

    for ( my $i = 2; $i * $i <= $value; ++$i ) {
        until ( $n % $i ) {
            push @results, $i;
            $n = int( $n / $i );
        }
    }

    push @results, $n
        unless $n == 1;

    return @results;

    my @primes = get_primes( int( sqrt $value ) );

    for my $prime ( @primes ) {
        last
            if $prime * $prime > $value;

        until ( $n % $prime ) {
            push @results, $prime;
            $n = int( $n / $prime );
        }
    }

    push @results, $n
        if $n > 1;

    return @results;
}

sub get_primes {
    my $number = shift;

    if ( $number <= $MAX_PRIME ) {
        my @results = ( );

        for my $prime ( @PRIMES ) {
            push @results, $prime;
            last
                if $prime > $number;
        }

        return @results;
    }

    cache_prime( $number );

    my @results = ( );

    for my $prime ( @PRIMES ) {
        push @results, $prime;
        last
            if $prime > $number;
    }

    return @results;
}

sub cache_prime {
    my $number = shift;

    if ( $number < 2 ) {
        $PRIMES[0] = 2;
        $MAX_PRIME = $number;
        return;
    }

    my @primes = ( 1 ) x ( $number + 1 );

    for ( my $i = 2; $i < $number; ++$i ) {
        for ( my $j = 2 * $i; $j < $number; $j += $i ) {
            $primes[ $j ] = 0;
        }
    }

    my $max = $PRIMES[-1] // 1;
    push @PRIMES, grep { $_ > $max && $primes[ $_ ] } ( 0 .. $#primes );
    $MAX_PRIME = $number;
}
