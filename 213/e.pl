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

my @NEIGHBORS = map { $_->[0] + $_->[1] * $w } (
    [ 1, 0 ],
    [ 0, 1 ],
    [ -1, 0 ],
    [ 0, -1 ],
);

my @PUNCH_NEIGHBORS = map { $_->[0] + $_->[1] * $w } (
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

    next
        if $visited[ $current ];

    $visited[ $current ]++;

    for my $candidate ( @NEIGHBORS ) {
        my $neighbor = $current + $candidate;

        next
            unless $neighbor >= 0 && $neighbor < $max_coord_exclusive;

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
        my $neighbor = $current + $candidate;

        next
            unless $neighbor >= 0 && $neighbor < $max_coord_exclusive;

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
