#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my $LEFT = 0;
my $DOWN = 1;
my $RD = 2;
my $LD = 3;

chomp( my $n = <> );
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

my @dp;

my $root_is = $s[0][0] eq q{#} ? 1 : 0;

$dp[0][0][ $LEFT ][0] = $root_is;
$dp[0][0][ $DOWN ][0] = $root_is;
$dp[0][0][ $RD ][0] = $root_is;
$dp[0][0][ $LD ][0] = $root_is;
$dp[0][0][ $LEFT ][1] = 1;
$dp[0][0][ $DOWN ][1] = 1;
$dp[0][0][ $RD ][1] = 1;
$dp[0][0][ $LD ][1] = 1;
$dp[0][0][ $LEFT ][2] = 1;
$dp[0][0][ $DOWN ][2] = 1;
$dp[0][0][ $RD ][2] = 1;
$dp[0][0][ $LD ][2] = 1;

for my $i ( 0 .. ( $n - 1 ) ) {
    for my $j ( 0 .. ( $n - 1 ) ) {
        my $is = $s[ $i ][ $j ] eq q{#} ? 1 : 0;
        # →
        if ( $j ) {
            $dp[ $i ][ $j ][ $LEFT ][2] = max(
                $dp[ $i ][ $j - 1 ][ $LEFT ][2] + $is,
                $dp[ $i ][ $j - 1 ][ $LEFT ][1] + 1,
            );
            $dp[ $i ][ $j ][ $LEFT ][1] = max(
                $dp[ $i ][ $j - 1 ][ $LEFT ][1] + $is,
                $dp[ $i ][ $j - 1 ][ $LEFT ][0] + 1,
            );
            $dp[ $i ][ $j ][ $LEFT ][0] = ( $dp[ $i ][ $j - 1 ][ $LEFT ][0] && $is )
                ? $dp[ $i ][ $j - 1 ][ $LEFT ][0] + 1
                : $is;
        }
        else {
            $dp[ $i ][ $j ][ $LEFT ][0] = $is;
            $dp[ $i ][ $j ][ $LEFT ][1] = 1;
            $dp[ $i ][ $j ][ $LEFT ][2] = 1;
        }

        # ↓
        if ( $i ) {
            $dp[ $i ][ $j ][ $DOWN ][2] = max(
                $dp[ $i - 1 ][ $j ][ $DOWN ][2] + $is,
                $dp[ $i - 1 ][ $j ][ $DOWN ][1] + 1,
            );
            $dp[ $i ][ $j ][ $DOWN ][1] = max(
                $dp[ $i - 1 ][ $j ][ $DOWN ][1] + $is,
                $dp[ $i - 1 ][ $j ][ $DOWN ][0] + 1,
            );
            $dp[ $i ][ $j ][ $DOWN ][0] = ( $dp[ $i - 1 ][ $j ][ $DOWN ][0] && $is )
                ? $dp[ $i - 1 ][ $j ][ $DOWN ][0] + 1
                : $is;
        }
        else {
            $dp[ $i ][ $j ][ $DOWN ][0] = $is;
            $dp[ $i ][ $j ][ $DOWN ][1] = 1;
            $dp[ $i ][ $j ][ $DOWN ][2] = 1;
        }

        # ↘︎
        if ( $i && $j ) {
            $dp[ $i ][ $j ][ $RD ][2] = max(
                $dp[ $i - 1 ][ $j - 1 ][ $RD ][2] + $is,
                $dp[ $i - 1 ][ $j - 1 ][ $RD ][1] + 1,
            );
            $dp[ $i ][ $j ][ $RD ][1] = max(
                $dp[ $i - 1 ][ $j - 1 ][ $RD ][1] + $is,
                $dp[ $i - 1 ][ $j - 1 ][ $RD ][0] + 1,
            );
            $dp[ $i ][ $j ][ $RD ][0] = ( $dp[ $i - 1 ][ $j - 1 ][ $RD ][0] && $is )
                ? $dp[ $i - 1 ][ $j - 1 ][ $RD ][0] + 1
                : $is;
        }
        else {
            $dp[ $i ][ $j ][ $RD ][0] = $is;
            $dp[ $i ][ $j ][ $RD ][1] = 1;
            $dp[ $i ][ $j ][ $RD ][2] = 1;
        }

        # ↙︎
        if ( $i && $j != ( $n - 1 ) ) {
            $dp[ $i ][ $j ][ $LD ][2] = max(
                $dp[ $i - 1 ][ $j + 1 ][ $LD ][2] + $is,
                $dp[ $i - 1 ][ $j + 1 ][ $LD ][1] + 1,
            );
            $dp[ $i ][ $j ][ $LD ][1] = max(
                $dp[ $i - 1 ][ $j + 1 ][ $LD ][1] + $is,
                $dp[ $i - 1 ][ $j + 1 ][ $LD ][0] + 1,
            );
            $dp[ $i ][ $j ][ $LD ][0] = ( $dp[ $i - 1 ][ $j + 1 ][ $LD ][0] && $is )
                ? $dp[ $i - 1 ][ $j + 1 ][ $LD ][0] + 1
                : $is;
        }
        else {
            $dp[ $i ][ $j ][ $LD ][0] = $is;
            $dp[ $i ][ $j ][ $LD ][1] = 1;
            $dp[ $i ][ $j ][ $LD ][2] = 1;
        }

        my $yes = grep { $_ >= 6 } map { @{ $_ } } @{ $dp[ $i ][ $j ] };

        if ( $yes ) {
            say "Yes";
            exit;
        }
    }
}

say "No";

exit;

