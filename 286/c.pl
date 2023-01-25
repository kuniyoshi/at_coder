#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $n, $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = do { chomp( my $l = <> ); split m{}, $l };

my $min = $n * $b;

for my $i ( 0 .. $n - 1 ) {
    my $cost = $i * $a;

    do {
        my $l = 0;
        my $r = $#s;
        while ( $l < $r ) {
            $cost += $b
                if $s[ $l ] ne $s[ $r ];
            $l++;
            $r--;
        }
    };

    $min = min( $min, $cost );
    push @s, shift @s;
}

say $min;

exit;
