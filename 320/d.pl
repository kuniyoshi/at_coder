#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;

my @deltas;
my %links;

for my $ref ( @edges ) {
    my( $from, $to, $dx, $dy ) = @{ $ref };
    $deltas[ $from ][ $to ] = [ $dx, $dy ];
    $deltas[ $to ][ $from ] = [ -$dx, -$dy ];

    push @{ $links{ $from } }, $to;
    push @{ $links{ $to } }, $from;
}

my @positions = (
    undef,
    [ 0, 0 ],
);

my @queue = ( 1 );
my %visited;

while ( @queue ) {
    my $cursor = shift @queue;
    next
        if $visited{ $cursor }++;

    for my $neighbor ( @{ $links{ $cursor } } ) {
        next
            if $visited{ $neighbor };

        my( $fx, $fy ) = @{ $positions[ $cursor ] };
        my( $dx, $dy ) = @{ $deltas[ $cursor ][ $neighbor ] };
        $positions[ $neighbor ] = [ $fx + $dx, $fy + $dy ];

        push @queue, $neighbor;
    }
}

if ( grep { !defined } @positions[ 1 .. $n ] ) {
    say "undecidable";
    exit;
}

print map { join( q{ }, @{ $_ } ), "\n" } @positions[ 1 .. $n ];

exit;
