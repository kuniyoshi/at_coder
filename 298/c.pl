#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my @boxes;
my %cards;

for my $ref ( @queries ) {
    my $op = $ref->[0];

    if ( $op == 1 ) {
        my( $value, $to ) = @{ $ref }[ 1, 2 ];
        push @{ ( $boxes[ $to - 1 ] //= [ ] ) }, $value;
        ${ ( $cards{ $value } //= { } ) }{ $to }++;
    }

    if ( $op == 2 ) {
        my $box = $ref->[1];
        say join q{ }, sort { $a <=> $b } @{ $boxes[ $box - 1 ] };
    }

    if ( $op == 3 ) {
        my $card = $ref->[1];
        say join q{ }, sort { $a <=> $b } keys %{ $cards{ $card } };
    }
}

exit;
use strict;
use warnings;

package PriorityQueue::PriorSmall;

sub new {
    my $class = shift;
    return bless { items => [ ] }, $class;
}

sub items {
    my $self = shift;
    return @{ $self->{items} };
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

package PriorityQueue::PriorLarge;

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
    Heap::push_to( $self->{items}, $value );
}

sub pop {
    my $self = shift;

    die "Could not pop while buffer is empty"
        unless @{ $self->{items} };

    return Heap::pop_from( $self->{items} );
}

sub peek {
    return shift->{items}[0];
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
            if $buffer_ref->[ $parent ] <= $buffer_ref->[ $cursor ];
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
            if $buffer_ref->[ $cursor ] <= $buffer_ref->[ $child ];

        $cursor = $child;
    }

    return $last_root;
}

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

1;
