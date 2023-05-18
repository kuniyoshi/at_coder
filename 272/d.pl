#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };

my @moves = get_moves( $n, $m );

my @queue = ( [ 0, 0, 0 ] );
my @distances = map { [ ( undef ) x $n ] } 1 .. $n;

while ( @queue ) {
    my $cursor = shift @queue;
    my( $row, $col, $dist ) = @{ $cursor };

    next
        if defined $distances[ $row ][ $col ];
    $distances[ $row ][ $col ] = $dist;

    for my $move ( @moves ) {
        my( $d_row, $d_col ) = @{ $move };
        my $n_row = $row + $d_row;
        my $n_col = $col + $d_col;
        next
            if $n_row < 0 || $n_row >= $n;
        next
            if $n_col < 0 || $n_col >= $n;
        next
            if defined $distances[ $n_row ][ $n_col ];
        push @queue, [ $n_row, $n_col, $dist + 1 ];
    }
}

for my $i ( 0 .. $n - 1 ) {
    say join q{ }, map { $distances[ $i ][ $_ ] // -1 } 0 .. $n - 1;
}

exit;

sub get_moves {
    my $n = shift;
    my $m = shift;
    my @moves;

    for my $i ( -$n .. $n ) {
        for my $j ( -$n .. $n ) {
            push @moves, [ $i, $j ]
                if $i ** 2 + $j ** 2 == $m;
        }
    }

    return @moves;
}
