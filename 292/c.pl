#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Memoize;

memoize( "f" );
memoize( "r" );
memoize( "g" );
memoize( "c" );
memoize( "kaijou" );

chomp( my $n = <> );

my $count = 0;

for my $ab ( 1 .. $n - 1 / 2 ) {
    my $cd = $n - $ab;
    $count += g( $ab ) * g( $cd );
}

say $count;

exit;

sub g {
    my $n = shift;
    my @numbers = r( $n );
    #    warn "g($n)";
    #    warn Dumper \@numbers;
    #    warn scalar @numbers;
    my $count = 0;
    for my $i ( 1 .. @numbers - 1 ) {
        $count += c( scalar( @numbers ), $i );
    }
    #    warn "g($n) = $count";
    return $count;
}

sub c {
    my $n = shift;
    my $c = shift;
    my $numerator = 1;
    $numerator *= $_
        for ( $n - $c + 1 ) .. $n;
    my $denominator = kaijou( $c );

    #    warn "c($n, $c) -> $numerator / $denominator = ", $numerator / $denominator;
    return $numerator / $denominator;
}

sub kaijou {
    my $n = shift;
    my $result = 1;
    while ( $n > 1 ) {
        $result *= $n;
        $n--;
    }
    return $result;
}

sub f {
    my $n = shift;
    my $count = 1;
    for my $a ( 2 .. sqrt( $n ) ) {
        next
            if $n % $a;
        my $acc = $n;
        while ( $acc % $a == 0 ) {
            $count++;
            $acc /= $a;
        }
    }
    return $count * 1;
}

sub r {
    my $n = shift;
    my @numbers = ( 1 );
    for my $i ( 2 .. sqrt( $n ) ) {
        my $acc = $n;
        while ( ( $acc % $i ) == 0 ) {
            push @numbers, $i;
            $acc /= $i;
        }
    }
    return @numbers;
}
