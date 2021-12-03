#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

my( $n, $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };
my( $p, $q, $r, $s ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $min_k1 = max( 1 - $a, 1 - $b );
my $max_k1 = min( $n - $a, $n - $b );

my $min_k2 = max( 1 - $a, $b - $n );
my $max_k2 = min( $n - $a, $b - 1 );

my @top1 = ( $a + $min_k1, $b + $min_k1 );
my @top2 = ( $a + $min_k2, $b - $min_k2 );

for ( my $i = $p; $i <= $q; ++$i ) {
    for ( my $j = $r; $j <= $s; ++$j ) {
        my $is;

        my @d1 = ( $i - $top1[0], $j - $top1[1] );
        $is++
            if $d1[0] == $d1[1];

        my @d2 = ( $i - $top2[0], $j - $top2[1] );
        $is++
            if -$d2[0] == $d2[1];

        print $is ? "#" : ".";
    }

    print "\n";
}

exit;

