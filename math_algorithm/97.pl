#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $l, $r ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $sqrt = sqrt( $r );

my @is_prime = ( 1 ) x ( 1 + $sqrt );
$is_prime[0] = 0;
$is_prime[1] = 0;
my @numbers = ( 1 ) x ( $r - $l + 1 );
$numbers[0] = 0
    if $l == 1;

for my $i ( 2 .. $sqrt ) {
    next
        unless $is_prime[ $i ];

    for ( my $j = $i + $i; $j < @is_prime; $j += $i ) {
        $is_prime[ $j ] = 0;
    }

    my $value = int( $l / $i ) * $i;
    my $index = $value - $l;
    $index += $i
        if $index < 0;

    for ( my $j = $index; $j < @numbers; $j += $i ) {
        next
            if $j + $l == $i;
        $numbers[ $j ] = 0;
    }
}

say scalar grep { $_ } @numbers;

exit;
