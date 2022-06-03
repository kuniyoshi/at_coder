#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $whole = ( 1 + $n ) * $n / 2;
my $sum_a = calc( $n, $a );
my $sum_b = calc( $n, $b );
my $sum_ab = calc( $n, lcm( $a, $b ) );

say $whole - $sum_a - $sum_b + $sum_ab;

exit;

sub calc {
    my( $n, $a ) = @_;
    my $count = int( $n / $a );
    my $sum = $count * ( $a + $count * $a ) / 2;
    return $sum;
}

sub gcd {
    my( $a, $b ) = @_;
    return $a
        if $b == 0;
    return gcd( $b, $a % $b );
}

sub lcm {
    my( $a, $b ) = @_;
    return $a / gcd( $a, $b ) * $b;
}
