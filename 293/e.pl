#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $x, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };

my @pows = ( 1 );

for my $i ( 1 .. sqrt( $x ) + 1 ) {
    $pows[ $i ] = ( $pows[ $i - 1 ] * $a ) % $m;
}

my $acc = 0;

for my $i ( 0 .. log( $x ) / log( 2 ) + 1 ) {
    last
        if $i > $x;

    my $p = 0;
    my $t = 1;
    while ( $i ) {
        my $b = 1 & $i;

        if ( $b ) {
            $t *= $pows[ 2 ** $p ] % $m;
        }

        $p++;
        $i >>= 1;
    }

    $acc = ( $acc + $t ) % $m;
}

say $acc;

exit;
