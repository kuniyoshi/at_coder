#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $t = <> );

PROBLEM:
while ( $t-- ) {
    chomp( my $n = <> );
    chomp( my @lines = ( map { scalar <> } 1 .. $n ) );
    my @ranges = sort { $b->[0] <=> $a->[0] }
                 map  { [ split m{\s}, $_ ] }
                 @lines;

    my $cursor = 0;

    for my $range_ref ( @ranges ) {
        my( $l, $r ) = @{ $range_ref };
    }

    say "yes";
}


exit;

package PriorityQueue;

sub new {
    my $class = shift;
    my $items_ref = shift;
    return bless { items => $items_ref }, $class;
}

sub push {
    my $self = shift;
    my $value = shift;
    Heap::push_to( $self->{items}, $value );
}

sub pop {
    my $self = shift;
    return Heap::pop_from( $self->{items} );
}

sub peek {
    return shift->{ items }[0];
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
            if $buffer_ref->[ $parent ] < $buffer_ref->[ $cursor ];
        $cursor = $parent;
    }
}

sub pop_from {
    my $buffer_ref = shift;
    my $n = $#{ $buffer_ref };
    my $root = $buffer_ref->[0];
    $buffer_ref->[0] = $buffer_ref->[ $n ];
    $#{ $buffer_ref }--;

    my $i = 0;

    while ( ( my $j = 2 * $i + 1 ) < $n ) {
        # greater child
        $j++
            if ( $j != $n - 1 ) && $buffer_ref->[ $j ] < $buffer_ref->[ $j + 1 ];
        @{ $buffer_ref }[ $j, $i ] = @{ $buffer_ref }[ $i, $j ]
            if $buffer_ref->[ $i ] < $buffer_ref->[ $j ];
        $i = $j;
    }

    return $root;
}
