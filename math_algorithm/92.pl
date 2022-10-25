#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $area = <> );

my $max_edge = sqrt( $area ) + 1;

my @numbers = ( 1 );

my $current = $area;

for my $i ( 2 .. $max_edge ) {
    while ( ( $current % $i ) == 0 ) {
        push @numbers, $i;
        $current /= $i;
    }
}

my $min;

for my $pattern ( 0 .. ( 2 ** @numbers - 1 ) ) {
    my $edge = 1;

    for my $i ( 0 .. $#numbers ) {
        if ( $pattern & ( 1 << $i ) ) {
            $edge *= $numbers[ $i ];
        }
    }

    my $other = $area / $edge;
    my $loop = $edge * 2 + $other * 2;

    $min = min( $min // $loop, $loop );
}

say $min;

exit;

