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

my $started = [ gettimeofday ];

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

while ( @deque ) {
    my $current = shift @deque;

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

        set_cost( $neighbor, $current_cost + 1 );
        push @deque, $neighbor;
    }
}

say $cost{ $w - 1 }{ $h - 1 };

warn "total elapsed: ", tv_interval( $started );


exit;

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

sub is_wall_at {
    my( $x, $y ) = @{ shift ( ) };
    return $coords[ $y ][ $x ] eq q{#};
}

sub cost_of {
    my $coord = shift
        or return 0;
    my( $x, $y ) = @{ $coord };
    $cost{ $x } = { }
            unless exists $cost{ $x };
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
