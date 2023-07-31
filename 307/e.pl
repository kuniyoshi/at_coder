#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MOD = 998244353;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp = ( 0, $m );

for ( my $i = 1; $i <= $n; ++$i ) {
    my @values = @dp;
    $dp[0] = $values[0] * ( $m - 2 ) + $values[1] * ( $m - 1 );
    $dp[1] = $values[0];
    $_ %= $MOD
        for @dp;
}

say $dp[1];

exit;
