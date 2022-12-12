#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = sort { $a <=> $b } do { chomp( my $l = <> ); split m{\s}, $l };

my @dp;
$dp[0][0][0] = 1;

for my $s ( 0 .. $k ) {
    for my $t ( 1 .. $n ) {
        for my $u ( 0 .. $d - 1 ) {
            if ( $dp[ $s ][ $t - 1 ][ $u ] ) {
                $dp[ $s ][ $t ][ $u ]++;
                $dp[ $s + 1 ][ $t ][ ( $u + $a[ $t - 1 ] ) % $d ]++;
            }
        }
    }
}


say answer( ) // -1;

exit;

sub answer {
    my $remain = $k;
    my $total = 0;
    my $mod = 0;

    for my $t ( reverse 1 .. $n ) {
        if ( $dp[ $remain ][ $t ][ $mod ] && $dp[ $remain - 1 ][ $t - 1 ][ ( $d + $mod - ( $a[ $t - 1 ] % $d ) ) % $d ] ) {
            $total += $a[ $t - 1 ];
            $remain--;
            $mod = ( $d + $mod - ( $a[ $t - 1] % $d ) ) % $d;

            if ( $remain == 0 ) {
                return $total;
            }
        }
    }

    return;
}
