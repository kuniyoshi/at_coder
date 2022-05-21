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

my @links;
my %cost;

for my $i ( 0 .. $#edges ) {
    my $ref = $edges[ $i ];
    my( $a, $b, $cost ) = @{ $ref };
    $a--;
    $b--;
    push @{ $links[ $a ] }, $b;
    push @{ $links[ $b ] }, $a;
    $cost{ $a }{ $b } = [ $cost, $i ];
    $cost{ $b }{ $a } = [ $cost, $i ];
}

my $queue = PriorityQueue::PriorSmall->new;
my %visited;

for my $neighbor ( @{ $links[0] } ) {
    $queue->push( [ $cost{0}{ $neighbor }[0], $neighbor, $cost{0}{ $neighbor }[1] ] );
}

$visited{0}++;

my @ways;

while ( $queue->size ) {
    my $ref = $queue->pop;
    my( $edge_cost, $v, $way ) = @{ $ref };

    next
        if $visited{ $v }++;

    push @ways, $way
        if defined $way;

    for my $neighbor ( @{ $links[ $v ] } ) {
        next
            if $visited{ $neighbor };
        $queue->push( [ $cost{ $v }{ $neighbor }[0], $neighbor, $cost{ $v }{ $neighbor }[1] ] );
    }
}

say join q{ }, map { $_ + 1 } @ways;

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
