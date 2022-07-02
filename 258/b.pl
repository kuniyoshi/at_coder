#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @a = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

my @directions = (
    [ -1, 0 ],
    [ -1, 1 ],
    [ 0, 1 ],
    [ 1, 1 ],
    [ 1, 0 ],
    [ 1, -1 ],
    [ 0, -1 ],
    [ -1, -1 ],
);

my $max = 0;

for my $i ( 0 .. $n - 1 ) {
    for my $j ( 0 .. $n - 1 ) {
        for my $d_ref ( @directions ) {
            my @numbers;

            for my $k ( 0 .. $n - 1 ) {
                push @numbers, $a[ ( $i - 1 + $k * $d_ref->[0] ) % $n ][ ( $j - 1 + $k * $d_ref->[1] ) % $n ];
            }

            $max = max( $max, join q{}, @numbers );
        }
    }
}

say $max;

exit;
