#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %bin;
$bin{ $_ }++
    for @a;

my @bins = keys %bin;

my @dp;
$dp[0][0] = 1;

for my $i ( 0 .. @bins ) {
    for my $j ( 0 .. 3 ) {

    }
}


exit;

