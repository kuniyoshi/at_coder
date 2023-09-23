#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

my( $n, $x, $y ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @g;

for ( my $i = 0; $i < sum( $x, $y ); ++$i ) {
    my %h;

    if ( $i - $x >= 0 ) {
        $h{ $g[ $i - $x ] }++;
    }

    if ( $i - $y >= 0 ) {
        $h{ $g[ $i - $y ] }++;
    }

    my $g = 0;

    $g++
        while $h{ $g };

    $g[ $i ] = $g;
}

my $acc = 0;

for my $a ( @a ) {
    $acc ^= $g[ $a % @g ];
}

say $acc ? "First" : "Second";

exit;
