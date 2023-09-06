#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @cells = map { chomp; [ split m{} ] }
            map { scalar <> }
            1 .. $h;

# 11 10 9 8 7 6 5 4 3 2 1 0
# St Go W G G G G P P P P .
# S  G  # ^ > v < ^ > v < .

my @map;
my $ghost_mask = ( 1 << 8 ) | ( 1 << 7 ) | ( 1 << 6 ) | ( 1 << 5 );

create_map( );
relay_map( );

my $start;

FIND_START:
for ( my $i = 0; $i < $h; ++$i ) {
    for ( my $j = 0; $j < $w; ++$j ) {
        if ( $map[ $i ][ $j ] == 1 << 11 ) {
            $start = [ $i, $j ];
            last FIND_START;
        }
    }
}

die "Could not find start"
    unless $start;
    #warn "start: ($start->[0], $start->[1])";

my $step;

my @queue = ( [ $start, 0 ] );
my %visited;

while ( @queue ) {
    my $ref = shift @queue;
    my( $cursor, $distance ) = @{ $ref };
    #warn "($cursor->[0], $cursor->[1]): $distance";
    next
        if $visited{ $cursor->[0] }{ $cursor->[1] }++;
    if ( $map[ $cursor->[0] ][ $cursor->[1] ] == 1 << 10 ) {
        $step = $distance;
        last;
    }
    push @queue, map { [ $_, $distance + 1 ] }
                 grep {
                     my( $i, $j ) = @{ $_ };
                     $i >= 0 && $i < $h && $j >= 0 && $j < $w && ( $map[ $i ][ $j ] == 0 || $map[ $i ][ $j ] == 1 << 10 ) && !$visited{ $i }{ $j };
                 }
                 map { [ $_->[0] + $cursor->[0], $_->[1] + $cursor->[1] ] }
                 ( [ 1, 0 ], [ 0, 1 ], [ -1, 0 ], [ 0, -1 ] );
}

say $step // -1;

exit;

sub relay_map {
    for ( my $i = $h - 1 ; $i >= 0; --$i ) {
        for ( my $j = $w - 1; $j >= 0; --$j ) {
            next
                if $cells[ $i ][ $j ] ne q{.};

            if ( $i + 1 == $h && $j + 1 == $w ) {
                # do nothing
            }
            elsif ( $i + 1 == $h ) {
                $map[ $i ][ $j ] |= $map[ $i ][ $j + 1 ] & 1 << 5;
            }
            elsif ( $j + 1 == $w ) {
                $map[ $i ][ $j ] |= $map[ $i + 1 ][ $j ] & 1 << 8;
            }
            else {
                $map[ $i ][ $j ] |= ( $map[ $i + 1 ][ $j ] & 1 << 8 ) | ( $map[ $i ][ $j + 1 ] & 1 << 5 );
            }
        }
    }
}

sub create_map {
    for ( my $i = 0; $i < $h; ++$i ) {
        for ( my $j = 0; $j < $w; ++$j ) {
            if ( $cells[ $i ][ $j ] eq q{.} ) {
                if ( $i > 0 && $j > 0 ) {
                    $map[ $i ][ $j ] = ( $map[ $i - 1 ][ $j ] & 1 << 6 ) | ( $map[ $i ][ $j - 1 ] & 1 << 7 );
                }
                elsif ( $i > 0 ) {
                    $map[ $i ][ $j ] = $map[ $i - 1 ][ $j ] & 1 << 6;
                }
                elsif ( $j > 0 ) {
                    $map[ $i ][ $j ] = $map[ $i ][ $j - 1 ] & 1 << 7;
                }
                else {
                    $map[ $i ][ $j ] = 0;
                }
            }
            elsif ( $cells[ $i ][ $j ] eq q{^} ) {
                $map[ $i ][ $j ] = ( 1 << 4 ) | ( 1 << 8 );
            }
            elsif ( $cells[ $i ][ $j ] eq q{>} ) {
                $map[ $i ][ $j ] = ( 1 << 3 ) | ( 1 << 7 );
            }
            elsif ( $cells[ $i ][ $j ] eq q{v} ) {
                $map[ $i ][ $j ] = ( 1 << 2 ) | ( 1 << 6 );
            }
            elsif ( $cells[ $i ][ $j ] eq q{<} ) {
                $map[ $i ][ $j ] = ( 1 << 1 ) | ( 1 << 5 );
            }
            elsif ( $cells[ $i ][ $j ] eq q{#} ) {
                $map[ $i ][ $j ] = 1 << 9;
            }
            elsif ( $cells[ $i ][ $j ] eq q{G} ) {
                $map[ $i ][ $j ] = 1 << 10;
            }
            elsif ( $cells[ $i ][ $j ] eq q{S} ) {
                $map[ $i ][ $j ] = 1 << 11;
            }
            else {
                die "Unknown symbol: $cells[ $i ][ $j ]";
            }
        }
    }
}
