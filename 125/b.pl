#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @v = do { chomp( my $l = <> ); split m{\s}, $l };
my @c = do { chomp( my $l = <> ); split m{\s}, $l };

my $total = 0;

for my $i ( 0 .. $n - 1 ) {
    my $benefit = $v[ $i ] - $c[ $i ];
    next
        unless $benefit > 0;
    $total += $benefit;
}

say $total;

exit;
