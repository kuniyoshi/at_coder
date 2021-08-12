#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Time::HiRes qw( tv_interval gettimeofday );

# TIME PASSED
# 🍅🍅🍅🍅🍅🍅🍅🍅🍅
#

my( $h, $w ) = split m{\s}, <>;
chomp( my @lines = <> );
my @coords = map { split m{}, $_ } @lines;
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
my %cost = ( );
my %visited = ( );

$cost{ $_ } = $max_cost
    for map { my $x = $_; map { $x + $w * $_ } 0 .. $h - 1 } 0 .. $w - 1;
$cost{ 0 } = 0;

unshift @deque, 0;

while ( @deque ) {
    my $current = shift @deque;

    next
        if $current < 0;

    next
        if $visited{ $current };

    $visited{ $current }++;

    my $current_cost = $cost{ $current };

    for my $candidate ( @NEIGHBORS ) {
        my $neighbor = $current + $candidate;

        next
            if $visited{ $neighbor };

        next
            unless $neighbor >= 0 && $neighbor < $max_coord_exclusive;

        next
            if $neighbor < 0;

        my $is_wall = $coords[ $neighbor ] eq q{#};

        if ( $current_cost + $is_wall < $cost{ $neighbor } ) {
            $cost{ $neighbor } = $current_cost + $is_wall;
        }

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
            if $visited{ $neighbor };

        next
            unless $neighbor >= 0 && $neighbor < $max_coord_exclusive;

        next
            if $neighbor < 0;

        if ( $current_cost + 1 < $cost{ $neighbor } ) {
            $cost{ $neighbor } = $current_cost + 1;
        }

        push @deque, $neighbor;
    }
}

say $cost{ ( $w - 1 ) + ( $h - 1 ) * $w };

exit;
