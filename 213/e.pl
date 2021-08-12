#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

# TIME PASSED
# 🍅🍅🍅🍅🍅🍅🍅🍅🍅
#

my( $h, $w ) = split m{\s}, <>;
chomp( my @lines = <> );

my @walls = map { 0 + ( $_ eq q{#} ) } map { split m{}, $_ } @lines;
my $max_coord_exclusive = $h * $w;

my @NEIGHBORS = (
    [ 1, 0 ],
    [ 0, 1 ],
    [ -1, 0 ],
    [ 0, -1 ],
);

my @PUNCH_NEIGHBORS = (
    [ -1, -2 ],
    [ 0, -2 ],
    [ 1, -2 ],

    [ -2, -1 ],
    [ -1, -1 ],
    [ 1, -1 ],
    [ 2, -1 ],

    [ -2, 0 ],
    [ 2, 0 ],

    [ -2, 1 ],
    [ -1, 1 ],
    [ 1, 1 ],
    [ 2, 1 ],

    [ -1, 2 ],
    [ 0, 2 ],
    [ 1, 2 ],
);

my $max_cost = 100_000_000;

my @deque = ( );
my @cost = ( $max_cost ) x $max_coord_exclusive;
my @visited = ( 0 ) x $max_coord_exclusive;

$cost[ 0 ] = 0;

unshift @deque, 0;

while ( @deque ) {
    my $current = shift @deque;
    my $x = $current % $w;
    my $y = int( $current / $w );

    next
        if $visited[ $current ];

    $visited[ $current ]++;

    for my $candidate ( @NEIGHBORS ) {
        my $nx = $x + $candidate->[0];
        my $ny = $y + $candidate->[1];

        next
            unless $nx >= 0 && $nx < $w && $ny >= 0 && $ny < $h;

        my $neighbor = $nx + $ny * $w;

        next
            if $visited[ $neighbor ];

        my $is_wall = $walls[ $neighbor ];
        my $cost_candidate = $cost[ $current ] + $is_wall;
        $cost[ $neighbor ] = $cost_candidate < $cost[ $neighbor ]
            ? $cost_candidate
            : $cost[ $neighbor ];

        if ( $is_wall ) {
            push @deque, $neighbor;
        }

        if ( !$is_wall ) {
            unshift @deque, $neighbor;
        }
    }

    for my $candidate ( @PUNCH_NEIGHBORS ) {
        my $nx = $x + $candidate->[0];
        my $ny = $y + $candidate->[1];

        next
            unless $nx >= 0 && $nx < $w && $ny >= 0 && $ny < $h;

        my $neighbor = $nx + $ny * $w;

        next
            if $visited[ $neighbor ];

        my $cost_candidate = $cost[ $current ] + 1;
        $cost[ $neighbor ] = $cost_candidate < $cost[ $neighbor ]
            ? $cost_candidate
            : $cost[ $neighbor ];

        push @deque, $neighbor;
    }
}

say $cost[ $max_coord_exclusive - 1 ];

exit;
