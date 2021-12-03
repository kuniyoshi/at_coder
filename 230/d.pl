#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @walls = sort { $a->[0] <=> $b->[0] }
            map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

my $count = 0;
my $queue = PriorityQueue::PriorSmall->new;
#$queue->push( 3e9 );

push @walls, [ 3e9, 3e9 + 1 ];

while ( @walls ) {
    my $wall_ref = shift @walls;
    my $end = $wall_ref->[1];
    #    warn "### $end";

    if ( $queue->size && $end >= $queue->peek + $d ) {
        my $start = $queue->peek;
        $queue->pop
            while $queue->size && $queue->peek + $d < $end;
        shift @walls
            while @walls && $walls[0][0] < $start + $d;
            #        warn "\$start: $start";
            #        warn "\$end: $end";
        $count++;
        #arn "next" if $wall_ref->[0] < $start + $d;
        next
            if $wall_ref->[0] < $start + $d;
    }

    #    warn "push: $end";
    $queue->push( $end );
}

say $count;

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
