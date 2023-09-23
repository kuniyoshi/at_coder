#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

my( $n, $x, $y ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $max = max( @a );

my @g;

for ( my $i = 0; $i <= $max; ++$i ) {
    my %candidate;

    if ( $i - $x >= 0 ) {
        $candidate{ $g[ $i - $x ] }++;
    }

    if ( $i - $y >= 0 ) {
        $candidate{ $g[ $i - $y ] }++;
    }

    my $g = 0;

    while ( $candidate{ $g } ) {
        $g++;
    }

    $g[ $i ] = $g;
}

my $acc = 0;

for my $a ( @a ) {
    $acc ^= $g[ $a ];
}

say $acc ? "First" : "Second";

exit;

