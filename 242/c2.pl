#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MOD = 998244353;

chomp( my $n = <> );

my @dp = ( 9 );

for my $i ( 1 .. ( $n - 1 ) ) {
    $dp[ $i ] = ( $dp[ $i - 1 ] * 3 - 2 ) % $MOD;
}

say $dp[ $n - 1 ];
