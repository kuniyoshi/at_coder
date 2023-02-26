#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $n = <> );
my @ab = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $n;

my @dp;

$dp[0][0] = 1;
$dp[0][1] = 1;

for my $i ( 1 .. $n - 1 ) {
    my $p = ( $ab[ $i ][0] != $ab[ $i - 1 ][0] ? $dp[ $i - 1 ][0] : 0 ) + ( $ab[ $i ][0] != $ab[ $i - 1 ][1] ? $dp[ $i - 1 ][1] : 0 );
    my $q = ( $ab[ $i ][1] != $ab[ $i - 1 ][0] ? $dp[ $i - 1 ][0] : 0 ) + ( $ab[ $i ][1] != $ab[ $i - 1 ][1] ? $dp[ $i - 1 ][1] : 0 );
    $dp[ $i ] = [ $p % 998244353, $q % 998244353 ];
}

say sum( @{ $dp[ $n - 1 ] } ) % 998244353;

exit;
