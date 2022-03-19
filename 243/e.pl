#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @l = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $m;

my @dp;

for my $i ( 0 .. ( $n - 1 ) ) {
    for my $j ( 0 .. ( $n - 1 ) ) {
        $dp[ $i ][ $j ] = 1e10;
    }
}

for my $edge_ref ( @l ) {
    my( $from, $to, $cost ) = @{ $edge_ref };
    $dp[ $from ][ $to ] = $cost;
    $dp[ $to ][ $from ] = $cost;
}

for my $k ( 0 .. ( $n - 1 ) ) {
    for my $i ( 0 .. ( $n - 1 ) ) {
        for my $j ( 0 .. ( $n - 1 ) ) {
            my $candidate = $dp[ $i ][ $k ] + $dp[ $k ][ $j ];
            $dp[ $i ][ $j ] = $candidate
                if $candidate < $dp[ $i ][ $j ];
        }
    }
}

exit;
