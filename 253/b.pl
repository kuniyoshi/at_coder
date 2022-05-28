#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

my @points;

for my $i ( 0 .. $h - 1 ) {
    for my $j ( 0 .. $w - 1 ) {
        next
            if $s[ $i ][ $j ] ne q{o};
        push @points, [ $i, $j ];
    }
}

die "invalid points count", scalar @points
    if @points != 2;

my $distance = abs( $points[0][0] - $points[1][0] )
               + abs( $points[0][1] - $points[1][1] );

say $distance;
exit;

