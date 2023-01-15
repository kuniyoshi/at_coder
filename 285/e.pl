#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

# $dp[曜日 i ][ 曜日 i が休日 ][ 曜日 j まで ] = 最大生産量
my @dp;
$dp[0][0] = [ ( undef ) x ( @a + 1 ) ];
$dp[0][1] = [ ( 0 ) x ( @a + 1 ) ];

for my $i ( 1 .. $n ) {
    my $last_holiday = 
    my $next_holiday = 
    for my $j ( 0, 1 ) {
        for my $k ( 0 .. $n ) {
            $dp[ $i ][ $j ][ $k ] = 
        }
    }
}

exit;
