#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

my @border_coords = (
    ( map { [ 0, $_ ] } 0 .. $n - 2 ),
    ( map { [ $_, $n - 1 ] } 0 .. $n - 2 ),
    ( map { [ $n - 1, $_ ] } reverse 1 .. $n - 1 ),
    ( map { [ $_, 0 ] } reverse 1 .. $n - 1 ),
);

my @coords = @border_coords;
unshift @coords, pop @coords;

my @b = map { [ @{ $_ } ] } @a;

for ( my $i = 0; $i < @coords; ++$i ) {
    $b[ $border_coords[ $i ][0] ][ $border_coords[ $i ][1] ] = $a[ $coords[ $i ][0] ][ $coords[ $i ][1] ];
}

print map { join( q{}, @{ $_ } ), "\n" } @b;


exit;
