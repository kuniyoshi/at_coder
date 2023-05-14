#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @h = sort { $a <=> $b }
        map { chomp; $_ }
        map { scalar <> }
        1 .. $n;

my $min = $h[-1] - $h[0];

for my $i ( 0 .. $n - 1 ) {
    last
        if $i + $k - 1 >= $n;
    $min = min( $min, $h[ $i + $k - 1 ] - $h[ $i ] );
}

say $min;

exit;
