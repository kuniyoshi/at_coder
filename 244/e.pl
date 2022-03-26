#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MOD = 998244353;

my( $n, $m, $k, $s, $t, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @links = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;
$s--;
$t--;
$x--;

my %edges;

for my $link_ref ( @links ) {
    my( $from, $to ) = @{ $link_ref };
    $from--;
    $to--;
    push @{ $edges{ $from } }, $to;
    push @{ $edges{ $to } }, $from;
}

my @dp;
$dp[0][ $_ ][0] = $dp[0][ $_ ][1] = 0
    for 0 .. $n - 1;

$dp[0][ $s ][0] = 1; # s != x

for my $ki ( 1 .. $k ) {
    for my $v ( 0 .. $n - 1 ) {
        next
            unless $edges{ $v };

        if ( $v == $x ) {
            for my $eo ( 0 .. 1 ) {
                my $invert = $eo ^ 1;

                for my $neighbor ( @{ $edges{ $v } } ) {
                    $dp[ $ki ][ $v ][ $eo ] += $dp[ $ki - 1 ][ $neighbor ][ $invert ];
                    $dp[ $ki ][ $v ][ $eo ] %= $MOD;
                }
            }
        }
        else {
            for my $eo ( 0 .. 1 ) {
                for my $neighbor ( @{ $edges{ $v } } ) {
                    $dp[ $ki ][ $v ][ $eo ] += $dp[ $ki - 1 ][ $neighbor ][ $eo ];
                    $dp[ $ki ][ $v ][ $eo ] %= $MOD;
                }
            }
        }

    }
}


say $dp[ $k ][ $t ][0];


exit;
