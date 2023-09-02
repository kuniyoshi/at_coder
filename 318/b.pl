#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @rectangles = map { chomp; [ split m{\s} ] }
                 map { scalar <> }
                 1 .. $n;

my @cells = map { [ ( 0 ) x 101 ] } 1 .. 101;

for my $ref ( @rectangles ) {
    my( $a, $b, $c, $d ) = @{ $ref };
    for ( my $i = $c; $i < $d; ++$i ) {
        for ( my $j = $a; $j < $b; ++$j ) {
            $cells[ $i ][ $j ]++;
        }
    }
}

say scalar grep { $_ > 0 } map { @{ $_ } } @cells;


exit;
