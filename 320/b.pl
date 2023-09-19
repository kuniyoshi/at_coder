#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my @s = do { chomp( my $l = <> ); split m{}, $l };

my $max = 0;

for ( my $i = 0; $i < @s; ++$i ) {
    my $length = 1;

    for ( my $j = 0; $j < @s; ++$j ) {
        last
            if $i - $j < 0 || $i + $j >= @s;
        last
            if $s[ $i - $j ] ne $s[ $i + $j ];
        $length = 1 + 2 * $j;
    }

    $max = max( $max, $length );
}

for ( my $i = 0; $i < @s; ++$i ) {
    my $length = 0;

    for ( my $j = 0; $j < @s; ++$j ) {
        my $left = $i - $j;
        my $right = $i + $j + 1;

        $length = 2 * ( $j;
        last
            if $i - $j < 0 || $i + $j >= @s;
        last
            if $s[ $i - $j ] ne $s[ $i + $j ];

    }

    $max = max( $max, $length );
}

say $max;

exit;
