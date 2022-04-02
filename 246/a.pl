#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

my @points = map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. 3;

my @mins = ( $points[0][0], $points[0][1] );
my @maxes = ( $points[0][0], $points[0][1] );

for my $ref ( @points ) {
    my( $x, $y ) = @{ $ref };
    $mins[0] = min( $mins[0], $x );
    $mins[1] = min( $mins[1], $y );

    $maxes[0] = max( $maxes[0], $x );
    $maxes[1] = max( $maxes[1], $y );
}

my @hole_points = (
    [ $mins[0], $mins[1] ],
    [ $maxes[0], $mins[1] ],
    [ $maxes[0], $maxes[1] ],
    [ $mins[0], $maxes[1] ],
);

my $ref;

for my $point_ref ( @hole_points ) {
    my( $x, $y ) = @{ $point_ref };
    my $is = grep { $_->[0] == $x && $_->[1] == $y } @points;
    next
        if $is;
    $ref = $point_ref;
}

say join q{ }, @{ $ref };


exit;
