#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @c = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

my @way;
$way[0][ $w ] = 0;
$way[ $h ][ $w ] = 0;

for ( my $i = 0; $i < $h; ++$i ) {
    for ( my $j = 0; $j < $w; ++$j ) {
        if ( $i == 0 && $j == 0 ) {
            $way[ $i ][ $j ] = 1;
            next;
        }
        if ( $c[ $i ][ $j ] eq q{#} ) {
            $way[ $i ][ $j ] = 0;
            next;
        }
        $way[ $i ][ $j ] = $way[ $i - 1 ][ $j ] || $way[ $i ][ $j - 1 ];
    }
}

my @dp;

for ( my $i = 0; $i < $h; ++$i ) {
    for ( my $j = 0; $j < $w; ++$j ) {
        my $addition = $way[ $i ][ $j ] // 0;
        my $up = $i > 0
            ? ( $dp[ $i - 1 ][ $j ] // 0 )
            : 0;
        my $left = $j > 0
            ? ( $dp[ $i ][ $j - 1 ] // 0 )
            : 0;
        $dp[ $i ][ $j ] = ( $up > $left ? $up : $left ) + $addition;
    }
}

say $dp[ $h - 1 ][ $w - 1 ];

exit;

