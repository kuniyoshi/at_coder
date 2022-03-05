#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MOD = 998244353;

chomp( my $n = <> );

# {1, 9}: A = 0
# {2, 3, 4, 5, 6, 7, 8}: B = 1

my $answer = 0;

for my $bit ( 1 .. 9 ) {
    $answer = $answer + mymod ( dfs( $n - 1, $bit ) );
}

say $answer;

# n = 3
# max( dp[i][j][k][0], dp[i][j][k][1] )



exit;

sub mymod {
    my $number = shift;
    return $number % $MOD;
}

sub dfs {
    my $current = shift;
    my $previous = shift;

    return $previous == 1 || $previous == 9 ? 2 : 3
        if $current == 1;

    return mymod( dfs( $current - 1, 1 ) ) + mymod( dfs( $current - 1, 2 ) )
        if $previous == 1;
    return mymod( dfs( $current - 1, 9 ) ) + mymod( dfs( $current - 1, 8 ) )
        if $previous == 9;

    return mymod( dfs( $current - 1, $previous - 1 ) ) + mymod( dfs( $current - 1, $previous ) ) + mymod( dfs( $current - 1, $previous + 1 ) );
}
