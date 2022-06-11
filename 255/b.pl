#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @positions = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $n;

my $max = 0;
my %has;
$has{ $_ - 1 }++
    for @a;

for my $i ( 0 .. $n - 1 ) {
    next
        if $has{ $i };

    my $min = 9e10;

    for my $j ( 0 .. $n - 1 ) {
        next
            if !$has{ $j };
        die "somehow"
            if $i == $j;
        my $x = $positions[ $i ][0] - $positions[ $j ][0];
        my $y = $positions[ $i ][1] - $positions[ $j ][1];
        die "same position"
            if $x == 0 && $y == 0;
        $min = min( $min, $x * $x + $y * $y );
    }

    $max = max( $max, $min );
}

say sqrt( $max );


exit;
