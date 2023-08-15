#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min sum );

my( $h, $w, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @ab = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $n;

my %is_hole;
$is_hole{ $_->[0] - 0 }{ $_->[1] - 0 }++
    for @ab;

my @dp = map { [ ( 0 ) x ( $w + 1 ) ] } 1 .. ( $h + 1 );

my $total = 0;

for ( my $i = 1; $i <= $h; ++$i ) {
    for ( my $j = 1; $j <= $w; ++$j ) {
        next
            if $is_hole{ $i }{ $j };
        $dp[ $i ][ $j ] = min( $dp[ $i - 1 ][ $j ], $dp[ $i ][ $j - 1 ], $dp[ $i - 1 ][ $j - 1 ] ) + 1;
        $total += $dp[ $i ][ $j ];
    }
}

say $total;
