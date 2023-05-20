#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

my @directions = (
    [-1, 0],
    [-1, 1],
    [0, 1],
    [1, 1],
    [1, 0],
    [1, -1],
    [0, -1],
    [-1, -1],
);
my @chars = qw( s n u k e );

my( $p, $direction ) = @{ find( ) }{ qw( point direction ) };

my( $row, $col ) = @{ $p };
my @points = map { [ $row + $_ * $direction->[0], $col + $_ * $direction->[1] ] }
             0 .. 4;

print map { $_->[0] + 1, q{ }, $_->[1] + 1, "\n" } @points;

exit;

sub find {
    for my $i ( 0 .. $h - 1 ) {
        for my $j ( 0 .. $w - 1 ) {
            DIRECTION:
            for my $direction ( @directions ) {
                for my $k ( 0 .. $#chars ) {
                    my $cursor_i = $i + $k * $direction->[0];
                    my $cursor_j = $j + $k * $direction->[1];
                    next DIRECTION
                        if $cursor_i < 0 || $cursor_i >= $h || $cursor_j < 0 || $cursor_j >= $w;
                    next DIRECTION
                        if $s[ $cursor_i ][ $cursor_j ] ne $chars[ $k ];
                }
                return { point => [ $i, $j ], direction => $direction };
            }
        }
    }
    die "No point found";
}
