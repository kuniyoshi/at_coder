#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

# TIME PASSED
# 🍅🍅🍅🍅
#

my @NEIGHBORS = (
    [ 1, 0 ],
    [ 0, 1 ],
    [ -1, 0 ],
    [ 0, -1 ],
);

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

unshift @deque, [ [ 0, 0 ], [ 0, 0 ] ];

while ( @deque ) {
    my( $current, $parent ) = @{ shift @deque };

    next
        if is_visited( $current );

    mark_visit( $current );

#warn "### ($current->[0], $current->[1]) <- ($parent->[0], $parent->[1])", ": ", cost_of( $current );

    for my $candidate ( @NEIGHBORS ) {
        my $neighbor = add_coord( $current, $candidate );

        next
            unless is_in_range( $neighbor );

        next
            if is_visited( $neighbor );

        my $is_wall = tile_of( $neighbor ) eq "#";

        set_cost( $neighbor, cost_of( $current ) + $is_wall );

        if ( $is_wall ) {
            push @deque, [ $neighbor, $current ];
        }

        if ( !$is_wall ) {
            unshift @deque, [ $neighbor, $current ];
        }
    }

    for my $delta_x ( -2 .. 2 ) {
        for my $delta_y ( -2 .. 2 ) {
            next
                if abs( $delta_x * $delta_y ) == 4;

            my $candidate = add_coord( $current, [ $delta_x, $delta_y ] );

            next
                unless is_in_range( $candidate );

            my $neighbor = $candidate;

            set_cost( $neighbor, cost_of( $current ) + 1 );
            push @deque, [ $neighbor, $current ];
        }
    }
}

#warn Dumper \%visited;
#warn Dumper \%cost;
say $cost{ $w - 1 }{ $h - 1 };

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
