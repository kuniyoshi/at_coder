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

my $started = [ gettimeofday ];

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

initialize_cost( $_, $max_cost )
    for map { my $x = $_; map { $x + $w * $_ } 0 .. $h - 1 } 0 .. $w - 1;
set_cost( 0, 0 );

unshift @deque, 0;

while ( @deque ) {
    my $current = shift @deque;

    next
        if $current < 0;

    next
        if is_visited( $current );

    mark_visit( $current );

    my $current_cost = cost_of( $current );

    for my $candidate ( @NEIGHBORS ) {
        my $neighbor = add_coord( $current, $candidate );

        next
            if is_visited( $neighbor );

        next
            unless is_in_range( $neighbor );

        next
            if $neighbor < 0;

        my $is_wall = is_wall_at( $neighbor );

        set_cost( $neighbor, $current_cost + $is_wall );

        if ( $is_wall ) {
            push @deque, $neighbor;
        }

        if ( !$is_wall ) {
            unshift @deque, $neighbor;
        }
    }

    for my $candidate ( @PUNCH_NEIGHBORS ) {
        my $neighbor = add_coord( $current, $candidate );

        next
            if is_visited( $neighbor );

        next
            unless is_in_range( $neighbor );

        next
            if $neighbor < 0;

        set_cost( $neighbor, $current_cost + 1 );
        push @deque, $neighbor;
    }
}

say $cost{ ( $w - 1 ) + ( $h - 1 ) * $w };

warn "total elapsed: ", tv_interval( $started );


exit;

sub initialize_cost {
    my $coord = shift;
    my $cost = shift;
    $cost{ $coord } = $cost;
}

sub set_cost {
    my $coord = shift;
    my $cost = shift;

    return
        if $cost > cost_of( $coord );

    $cost{ $coord } = $cost;
}

sub is_visited {
    my $coord = shift;

    return $visited{ $coord };
}

sub mark_visit {
    my $coord = shift;

    $visited{ $coord }++;
}

sub is_wall_at {
    my $coord = shift;

    return $coords[ $coord ] eq q{#};
}

sub cost_of {
    return $cost{ shift( ) };
}

sub is_in_range {
    my $coord = shift;
    return $coord >= 0 && $coord < $max_coord_exclusive;
}

sub add_coord {
    my( $a, $b ) = @_;
    return $a + $b;
}
