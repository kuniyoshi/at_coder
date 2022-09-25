#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $x, $y ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n - 1;

$x--;
$y--;

my %links_of;

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    $u--;
    $v--;
    push @{ $links_of{ $u } }, $v;
    push @{ $links_of{ $v } }, $u;
}

my @d;

for my $i ( 0 .. $n - 1 ) {
    $d[ $i ] = $i == $x ? 0 : 2 * $n;
}

my %previous;

my $queue = PriorityQueue::PriorSmall->new;
$queue->push( [ $d[ $x ], $x ] );

while ( $queue->size ) {
    my $ref = $queue->pop;
    my $u = $ref->[1];

    for my $v ( @{ $links_of{ $u } } ) {
        my $alternative = $d[ $u ] + 1;

        if ( $alternative < $d[ $v ] ) {
            $d[ $v ] = $alternative;
            $previous{ $v } = $u;
            $queue->push( [ $d[ $v ], $v ] );
        }
    }
}

my $cursor = $y;
my @passes;

while ( defined $previous{ $cursor } ) {
    push @passes, $cursor;
    $cursor = $previous{ $cursor };
}

push @passes, $x;

say join q{ }, map { $_ + 1 } reverse @passes;

exit;

use strict;
use warnings;

package PriorityQueue::PriorSmall;

sub new {
    my $class = shift;
    return bless { items => [ ] }, $class;
}

sub dump {
    my $self = shift;
    return join q{, }, @{ $self->{items} };
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

1;
