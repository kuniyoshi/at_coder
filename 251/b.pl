#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

my( $n, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %good;

for my $i ( 0 .. $#a ) {
    $good{ $a[ $i ] }++
        if $a[ $i ] <= $w;

    for my $j ( 0 .. $i - 1 ) {
        $good{ sum( @a[ $i, $j ] ) }++
            if sum( @a[ $i, $j ] ) <= $w;

        for my $k ( 0 .. $j - 1 ) {
            $good{ sum( @a[ $i, $j, $k ] ) }++
                if sum( @a[ $i, $j, $k ] ) <= $w;
        }
    }
}

say scalar %good;

exit;
