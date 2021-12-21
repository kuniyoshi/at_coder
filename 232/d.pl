#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @c = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

my $max = bfs( [ [ 0, 0 ] ], 0 );

say $max;

exit;

sub bfs {
    my $queue_ref = shift;
    my $steps = shift;

    if ( !@{ $queue_ref } ) {
        return $steps;
    }

    my( $row, $col ) = @{ shift @{ $queue_ref } };
    $steps++;

    my @nexts = (
        [ $row + 1, $col ],
        [ $row, $col + 1],
    );

    my $max = $steps;

    for my $next_ref ( @nexts ) {
        next
            if ( $c[ $next_ref->[0] ][ $next_ref->[1] ] // "#" )  eq q{#};
        my $candidate = bfs( [ @{ $queue_ref }, $next_ref ], $steps );
        $max = $candidate > $max ? $candidate : $max;
    }

    return $max;
}
