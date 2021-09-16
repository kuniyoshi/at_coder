#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $head = <> );
my( $n, $m ) = split m{\s}, $head;
my @edges = sort { $a->[2] <=> $b->[2] }
            map {
                chomp( my $line = <> );
                my $edge = [ split m{\s}, $line ];
                $edge->[0] = $edge->[0] - 1;
                $edge->[1] = $edge->[1] - 1;
                $edge;
            }
            ( 1 .. $m );

my $total_cost = ( sum grep { $_ > 0 } map { $_->[2] } @edges ) // 0;

my $tree = UnionFindTree->new( $n );

for my $edge_ref ( @edges ) {
    my( $from, $to, $cost ) = @{ $edge_ref };

    next
        if $tree->root( $from ) == $tree->root( $to );

    $tree->unite( $from, $to );
    $total_cost = $total_cost - $cost
        if $cost > 0;
}

say $total_cost;

exit;

package UnionFindTree;

sub unite {
    my $self = shift;
    my( $u, $v ) = @_;
    my( $root_u, $root_v ) = ( $self->root( $u ), $self->root( $v ) );

    return
        if $root_u == $root_v;

    $self->[ $root_v ] = $root_u;
}

sub root {
    my $self = shift;
    my $v = shift;
    my $parent = $self->[ $v ];

    return $v
        if $parent == $v;

    return $self->[ $v ] = $self->root( $parent );
}

sub new {
    my $class = shift;
    my $n = shift;
    return bless [ 0 .. $n - 1 ], $class;
}
