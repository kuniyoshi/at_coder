#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $n, $m, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;
my @hps = map { chomp; [ split m{\s} ] }
          map { scalar <> }
          1 .. $k;

my %links;

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    $u--;
    $v--;

    push @{ $links{ $u } }, $v;
    push @{ $links{ $v } }, $u;
}

my %hp;

for my $ref ( @hps ) {
    my( $p, $h ) = @{ $ref };
    $hp{ $p - 1 } = $h;
}

my $queue = PriorityQueue::PriorLarge->new;

$queue->push( [ $hp{ $_ }, $_ ] )
    for keys %hp;

while ( $queue->size ) {
    my( $hp, $u ) = @{ $queue->pop };

    $hp{ $u } = max( $hp{ $u } // 0, $hp );

    next
        if $hp < $hp{ $u };
    next
        if $hp == 0;

    for my $v ( @{ $links{ $u } // [ ] } ) {
        next
            if $hp - 1 < ( $hp{ $v } // 0 );
        $queue->push( [ $hp - 1, $v ] );
    }
}

say scalar %hp;
say join q{ }, map { $_ + 1 } sort { $a <=> $b } keys %hp;

exit;

use strict;
use warnings;

package PriorityQueue::PriorLarge;

sub new {
    my $class = shift;
    return bless { items => [ ] }, $class;
}

sub push {
    my $self = shift;
    my $value = shift;
    Heap::push_to( $self->{items}, $value );
}

sub pop {
    my $self = shift;

    die "Could not pop while buffer is empty"
        unless @{ $self->{items} };

    return Heap::pop_from( $self->{items} );
}

sub size {
    return @{ shift->{items} };
}

package Heap;

sub push_to {
    my( $buffer_ref, $item ) = @_;

    push @{ $buffer_ref }, $item;

    my $cursor = $#{ $buffer_ref };

    while ( $cursor != 0 ) {
        my $parent = int( ( $cursor - 1 ) / 2 );
        @{ $buffer_ref }[ $parent, $cursor ] = @{ $buffer_ref }[ $cursor, $parent ]
            if $buffer_ref->[ $parent ][0] <= $buffer_ref->[ $cursor ][0];
        $cursor = $parent;
    }
}

sub pop_from {
    my $buffer_ref = shift;

    my $last_root = $buffer_ref->[0];
    $buffer_ref->[0] = $buffer_ref->[-1];
    $#{ $buffer_ref }--;

    my $cursor = 0;

    while ( ( my $left = 2 * $cursor + 1 ) < @{ $buffer_ref } ) {
        my $right = $left + 1;

        my $child = $right < @{ $buffer_ref } && $buffer_ref->[ $left ] <= $buffer_ref->[ $right ]
            ? $right
            : $left;

        @{ $buffer_ref }[ $cursor, $child ] = @{ $buffer_ref }[ $child, $cursor ]
            if $buffer_ref->[ $cursor ][0] <= $buffer_ref->[ $child ][0];

        $cursor = $child;
    }

    return $last_root;
}

