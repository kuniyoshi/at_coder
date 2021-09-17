#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $head = <> );
my( $n, $m ) = split m{\s}, $head;
my @edges = map { chomp( my $line = <> ); [ split m{\s}, $line ] }
            ( 1 .. $m );

my %cost = ( );
my $total_cost = 0;

for my $edge_ref ( @edges ) {
    my( $from, $to, $cost ) = @{ $edge_ref };

    unless ( exists $cost{ $from }{ $to } ) {
        $cost{ $from }{ $to } = [ ];
        $cost{ $to }{ $from } = [ ];
    }

    push @{ $cost{ $from }{ $to } }, $cost;
    push @{ $cost{ $to }{ $from } }, $cost;

    $total_cost = $total_cost + $cost
        if $cost > 0;
}
#warn Dumper \%cost;

@edges = ( );
my %is_in_tree = ( );

my $queue = PriorityQueue::PriorSmall->new;
$queue->push( [ 0, 0 ] );
$cost{0}{1} = [ 0 ];

while ( $queue->size ) {
    my $ref = $queue->pop;
    #    warn "($ref->[0], $ref->[1])";

    next
        if $is_in_tree{ $ref->[0] }++;

    $total_cost = $total_cost - $ref->[1]
        if $ref->[1] > 0;

    my $neighbors_ref = delete $cost{ $ref->[0] };
    #    warn Dumper $neighbors_ref;

    while ( my( $key, $costs_ref ) = each %{ $neighbors_ref } ) {
        my( $cost ) = sort { $a <=> $b } @{ $costs_ref };
        $queue->push( [ $key, $cost ] )
            unless $is_in_tree{ $key };
    }
}

say $total_cost;

exit;

package PriorityQueue::PriorSmall;

sub new {
    my $class = shift;
    return bless { items => [ ] }, $class;
}

sub push {
    my $self = shift;
    my $value = shift;
    Heap::reverse_push_to( $self->{items}, $value );
}

sub pop {
    my $self = shift;

    die "Could not pop while buffer is empty"
        unless @{ $self->{items} };

    return Heap::reverse_pop_from( $self->{items} );
}

sub peek {
    return shift->{items}[0];
}

sub size {
    return @{ shift->{items} };
}

package Heap;

sub reverse_push_to {
    my( $buffer_ref, $item ) = @_;

    push @{ $buffer_ref }, $item;

    my $cursor = $#{ $buffer_ref };

    while ( $cursor != 0 ) {
        my $parent = int( ( $cursor - 1 ) / 2 );
        @{ $buffer_ref }[ $parent, $cursor ] = @{ $buffer_ref }[ $cursor, $parent ]
            if $buffer_ref->[ $parent ][1] >= $buffer_ref->[ $cursor ][1];
        $cursor = $parent;
    }
}

sub reverse_pop_from {
    my $buffer_ref = shift;

    my $last_root = $buffer_ref->[0];
    $buffer_ref->[0] = $buffer_ref->[-1];
    $#{ $buffer_ref }--;

    my $cursor = 0;

    while ( ( my $left = 2 * $cursor + 1 ) < @{ $buffer_ref } ) {
        my $right = $left + 1;

        my $child = $right < @{ $buffer_ref } && $buffer_ref->[ $left ][1] >= $buffer_ref->[ $right ][1]
            ? $right
            : $left;

        @{ $buffer_ref }[ $cursor, $child ] = @{ $buffer_ref }[ $child, $cursor ]
            if $buffer_ref->[ $cursor ][1] >= $buffer_ref->[ $child ][1];

        $cursor = $child;
    }

    return $last_root;
}
