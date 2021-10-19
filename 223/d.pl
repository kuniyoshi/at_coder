#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $head = <> );
my( $n, $m ) = split m{\s}, $head;
my @edges = map { chomp; [ split m{\s} ] }
            map { <> }
            1 .. $m;

my %from_to;
my %to_from;

for my $edge_ref ( @edges ) {
    my( $from, $to ) = @{ $edge_ref };
    $from_to{ $from }{ $to }++;
    $to_from{ $to }{ $from }++;
}

my $queue = PriorityQueue::PriorSmall->new;
$queue->push( $_ )
    for grep { !exists $to_from{ $_ } }
        1 .. $n;

my @s;

while ( $queue->size ) {
    my $u = $queue->pop;

    push @s, $u;

    for my $to ( keys %{ $from_to{ $u } } ) {
        delete $to_from{ $to }{ $u };

        unless ( %{ $to_from{ $to } } ) {
            delete $to_from{ $to };
            $queue->push( $to );
        }
    }

    delete $to_from{ $u };
}

if ( %to_from ) {
    say -1;
    exit;
}

say join q{ }, @s;

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
            if $buffer_ref->[ $parent ] >= $buffer_ref->[ $cursor ];
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

        my $child = $right < @{ $buffer_ref } && $buffer_ref->[ $left ] >= $buffer_ref->[ $right ]
            ? $right
            : $left;

        @{ $buffer_ref }[ $cursor, $child ] = @{ $buffer_ref }[ $child, $cursor ]
            if $buffer_ref->[ $cursor ] >= $buffer_ref->[ $child ];

        $cursor = $child;
    }

    return $last_root;
}
