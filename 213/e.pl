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
my @h_stack = ( );
my @l_stack = ( );
my @cost = ( $max_cost ) x $max_coord_exclusive;
my @visited = ( 0 ) x $max_coord_exclusive;

$cost[ 0 ] = 0;

push @h_stack, 0;

while ( defined( my $current = pop @h_stack // pop @l_stack ) ) {
        #    my $current = pop @h_stack // pop @l_stack;
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

        #        next
        #            if $visited[ $neighbor ];

        next
            if $walls[ $neighbor ];

        next
            if $cost[ $neighbor ] <= $cost[ $current ];

        $cost[ $neighbor ] = $cost[ $current ];

        push @h_stack, $neighbor;
    }

    for my $cx ( -2 .. 2 ) {
        for my $cy ( -2 .. 2 ) {
            next
                if ( abs( $cx ) + abs( $cy ) ) > 3;

            my $nx = $x + $cx;
            my $ny = $y + $cy;

            next
                unless $nx >= 0 && $nx < $w && $ny >= 0 && $ny < $h;

            my $neighbor = $nx + $ny * $w;

            #            next
            #                if $visited[ $neighbor ];

            next
                if $cost[ $neighbor ] <= $cost[ $current ];

            $cost[ $neighbor ] = $cost[ $current ] + 1;

            push @l_stack, $neighbor;
        }
    }
}

say $cost[ $max_coord_exclusive - 1 ];

exit;
