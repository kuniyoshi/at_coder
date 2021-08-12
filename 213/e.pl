#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Time::HiRes qw( tv_interval gettimeofday );

# TIME PASSED
# 🍅🍅🍅🍅🍅🍅🍅
#

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
    [ 0, -1 ],
    [ 1, -1 ],
    [ 2, -1 ],

    [ -2, 0 ],
    [ -1, 0 ],
    [ 1, 0 ],
    [ 2, 0 ],

    [ -2, 1 ],
    [ -1, 1 ],
    [ 0, 1 ],
    [ 1, 1 ],
    [ 2, 1 ],

    [ -1, 2 ],
    [ 0, 2 ],
    [ 1, 2 ],
);

my %elapsed = ( );


my( $h, $w ) = split m{\s}, <>;
chomp( my @lines = <> );
my @coords = map { [ split m{}, $_ ] } @lines;

my $max_cost = 100_000_000;

my @deque = ( );
my %cost = ( );
my %visited = ( );

initialize_cost( $_, $max_cost )
    for map { my $x = $_; map { [ $x, $_ ] } 0 .. $h - 1 } 0 .. $w - 1;
set_cost( [ 0, 0 ], 0 );

unshift @deque, [ 0, 0 ];

my $started = [ gettimeofday ];
while ( @deque ) {
    my $current = shift @deque;

    next
        if $visited{ $current->[0] }{ $current->[1] };#is_visited( $current );

    mark_visit( $current );

#warn "### ($current->[0], $current->[1]) <- ($parent->[0], $parent->[1])", ": ", cost_of( $current );

    my $start = [ gettimeofday ];

    for my $candidate ( @NEIGHBORS ) {
        my $neighbor = add_coord( $current, $candidate );

        next
            unless is_in_range( $neighbor );

        next
            if $visited{ $neighbor->[0] }{ $neighbor->[1] };# is_visited( $neighbor );

        my $is_wall = tile_of( $neighbor ) eq "#";

        set_cost( $neighbor, cost_of( $current ) + $is_wall );

        if ( $is_wall ) {
            push @deque, $neighbor;
        }

        if ( !$is_wall ) {
            unshift @deque, $neighbor;
        }
    }

    $elapsed{neighbor} += tv_interval( $start );

    $start = [ gettimeofday ];

    for my $candidate ( @PUNCH_NEIGHBORS ) {
        my $neighbor = add_coord( $current, $candidate );

        next
            unless is_in_range( $neighbor );

        next
            if is_visited( $neighbor );

        set_cost( $neighbor, cost_of( $current ) + 1 );
        push @deque, $neighbor;
    }

    $elapsed{punch} += tv_interval( $start );
}

#warn Dumper \%visited;
#warn Dumper \%cost;
say $cost{ $w - 1 }{ $h - 1 };

warn "total elapsed: ", tv_interval( $started );
warn Dumper \%elapsed;


exit;

sub deque_push {
    my $start = [ gettimeofday ];
    push @deque, shift;
    $elapsed{push} += tv_interval( $start );
}

sub deque_unshift {
    my $start = [ gettimeofday ];
    unshift @deque, shift;
    $elapsed{unshift} += tv_interval( $start );
}

sub deque_shift {
    my $start = [ gettimeofday ];
    my $item = shift @deque;
    $elapsed{shift} += tv_interval( $start );

    return $item;
}

sub initialize_cost {
    my $coord = shift;
    my $cost = shift;
    my( $x, $y ) = @{ $coord };
    $cost{ $x }{ $y } = $cost;
}

sub set_cost {
    my $coord = shift;
    my $cost = shift;

    return
        if $cost > cost_of( $coord );

    my( $x, $y ) = @{ $coord };

    $cost{ $x }{ $y } = $cost;
    #warn "--- set_cost: ($x, $y) to $cost";
}

sub is_visited {
    my( $x, $y ) = @{ shift( ) };
    return $visited{ $x }{ $y };
}

sub mark_visit {
    my( $x, $y ) = @{ shift( ) };
    $visited{ $x }{ $y }++;
}

sub add_cost {
    my $coord = shift;
    my $cost = cost_of( $coord );
    my( $x, $y ) = @{ $coord };
    $cost{ $x }{ $y } = $cost + 1;
}

sub tile_of {
    my( $x, $y ) = @{ shift ( ) };
    return $coords[ $y ][ $x ];
}

sub cost_of {
    my $coord = shift
        or return 0;
    my( $x, $y ) = @{ $coord };
    #$cost{ $x } = { }
    #        unless exists $cost{ $x };
    return $cost{ $x }{ $y } // 0;
}

sub is_in_range {
    my( $x, $y ) = @{ shift( ) };
    return $x >= 0 && $x < $w
        && $y >= 0 && $y < $h;
}

sub add_coord {
    my( $a, $b ) = @_;
    return [ $a->[0] + $b->[0], $a->[1] + $b->[1] ];
}

package Deque;
{
    class Deque {
    }
}
