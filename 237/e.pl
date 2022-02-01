#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @h = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ map { $_ - 1 } split m{\s} ] }
            map { scalar <> }
            1 .. $n;

my @destinations;

for my $edge_ref ( @edges ) {
    my( $l, $r ) = @{ $edge_ref };
    push @{ $destinations[ $l ] }, $r;
    push @{ $destinations[ $r ] }, $l;
}

my $priority_queue = PriorityQueue::PriorSmall->new;
$priority_queue->push( [ 0, 0 ] );

my %cost;

while ( $priority_queue->size ) {
    my( $d, $c ) = @{ $priority_queue->pop };

    next
        if $d == $cost{ $c };

    for my $neighbor ( @{ $destinations[ $c ] } ) {
        my $new_cost = $h[ $neighbor ] > $h[ $c ] ? $h[ $neighbor ] - $h[ $c ] : 0;
        next
            if $new_cost >= $cost{ $neighbor };
        $cost{ $neighbor } = $new_cost;
        $priority_queue->push( [ $new_cost, $neighbor ] );
    }
}

my $max = 0;

for my $v ( 0 .. ( $n - 1 ) ) {
    my $cost = $h[0] - $h[ $v ] + $cost{ $v };
    $max = $cost > $max ? $cost : $max;
}

say $max;


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
    return scalar @{ shift->{items} };
}

package Heap;

sub reverse_push_to {
    my( $buffer_ref, $item ) = @_;

    push @{ $buffer_ref }, $item;

    my $cursor = $#{ $buffer_ref };

    while ( $cursor != 0 ) {
        my $parent = int( ( $cursor - 1 ) / 2 );
        @{ $buffer_ref }[ $parent, $cursor ] = @{ $buffer_ref }[ $cursor, $parent ]
            if $buffer_ref->[ $parent ][0] >= $buffer_ref->[ $cursor ][0];
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

        my $child = $right < @{ $buffer_ref } && $buffer_ref->[ $left ][0] >= $buffer_ref->[ $right ][0]
            ? $right
            : $left;

        @{ $buffer_ref }[ $cursor, $child ] = @{ $buffer_ref }[ $child, $cursor ]
            if $buffer_ref->[ $cursor ][0] >= $buffer_ref->[ $child ][0];

        $cursor = $child;
    }

    return $last_root;
}
