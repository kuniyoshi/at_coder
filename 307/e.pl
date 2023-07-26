#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MOD = 998244353;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp = map { [ ( $_ == 1 ) x $m ] } 1 .. $n;

for ( my $i = 1; $i < $n; ++$i ) {
    for ( my $j = 0; $j < $m; ++$j ) {
        for ( my $k = 0; $k < $m; ++$k ) {
            next
                if $k == $i;
            $dp[ $i ][ $j ] += $dp[ $i - 1 ][ $k ];
            $dp[ $i ][ $j ] %= $MOD;
        }
    }
}

die Dumper \@dp;
say $dp[ $n - 1 ][ $m - 1 ];


exit;
