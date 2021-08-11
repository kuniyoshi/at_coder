#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Readonly;

# TIME PASSED
# 🍅🍅🍅🍅
#

Readonly my @NEIGHBORS => (
    [ 1, 0 ],
    [ 0, 1 ],
    [ -1, 0 ],
    [ 0, -1 ],
);

my( $h, $w ) = split m{\s}, <>;
chomp( my @lines = <> );
my @coords = map { [ split m{}, $_ ] } @lines;

my @deque = ( );
my %cost = ( );
my %visited = ( );

unshift @deque, [ [ 0, 0 ], [ 0, 0 ] ];

while ( @deque ) {
    my( $current, $parent ) = @{ shift @deque };

    next
        if is_visited( $current );

    mark_visit( $current );

    warn "### ($current->[0], $current->[1]) <- ($parent->[0], $parent->[1])", ": ", cost_of( $current );

    for my $candidate ( @NEIGHBORS ) {
        my $neighbor = add_coord( $current, $candidate );

        next
            unless is_in_range( $neighbor );

        next
            if is_visited( $neighbor );

        my $is_wall = tile_of( $neighbor ) eq "#";

        if ( $is_wall ) {
            push @deque, [ $neighbor, $current ];
            set_cost( $neighbor, cost_of( $current ) + 1 );
        }

        if ( !$is_wall ) {
            unshift @deque, [ $neighbor, $current ];
            set_cost( $neighbor, cost_of( $current ) );
        }
    }
}

#warn Dumper \%visited;
warn Dumper \%cost;
say $cost{ $w - 1 }{ $h - 1 };

exit;

sub set_cost {
    my $coord = shift;
    my $cost = shift;
    my( $x, $y ) = @{ $coord };
    $cost{ $x }{ $y } = $cost;
    warn "--- set_cost: ($x, $y) to $cost";
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
