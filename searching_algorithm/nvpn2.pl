#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Readonly;

Readonly my %MAX => (
    depth => 4,
    width => 2,
);

Readonly my %N => (
    dog => 0.4,
    cat => 0.6,
);
Readonly my %V => (
    runs => 0.5,
    jumps => 0.5,
);
Readonly my %P => (
    in => 0.4,
    on => 0.6,
);
Readonly my %N2 => (
    garden => 0.7,
    tree => 0.3,
);

Readonly my @PATHS => ( \%N, \%V, \%P, \%N2 );

my $states_ref = beam_search( [ State->new ], 0 );
print map { $_->to_string, "\n" } @{ $states_ref };

exit;

sub beam_search {
    my $states_ref = shift;
    my $depth = shift;

    return $states_ref
        if $depth == $MAX{depth};

    my $queue = PriorityQueue::PriorLarge->new;

    for my $state ( @{ $states_ref } ) {
        if ( $state->is_done ) {
            $queue->push( $state );
            next;
        }

        for my $move ( $state->legal_moves ) {
            $queue->push( $state->move( $move ) );
        }
    }

    my @states;

    while ( @states < $MAX{width} && $queue->size ) {
        push @states, $queue->pop;
    }

    return beam_search( \@states, $depth + 1 );
}

package State {
    sub new {
        return bless { moves => [ ] }, shift;
    }

    sub to_string {
        my $self = shift;
        return join q{ }, @{ $self->{moves} };
    }

    sub clone {
        my $self = shift;
        return bless { moves => [ @{ $self->{moves} } ] }, ref $self;
    }

    sub score {
        my $self = shift;
        my $score = 0;
        for ( my $i = 0; $i < @{ $self->{moves} }; ++$i ) {
            last
                if $i >= @PATHS;
            $score += $PATHS[ $i ]{ $self->{moves}[ $i ] } // 0;
        }
        return $score;
    }

    sub move {
        my $self = shift;
        my $move = shift;
        die "done already"
            if $self->is_done;
        my $new = $self->clone;
        push @{ $new->{moves} }, $move;
        return $new;
    }

    sub is_done {
        my $self = shift;
        return @{ $self->{moves} } == @PATHS;
    }

    sub legal_moves {
        my $self = shift;
        return
            if $self->is_done;
        return keys %{ $PATHS[ scalar @{ $self->{moves} } ] };
    }
}

use strict;
use warnings;

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
            if $buffer_ref->[ $parent ]->score <= $buffer_ref->[ $cursor ]->score;
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

        my $child = $right < @{ $buffer_ref } && $buffer_ref->[ $left ]->score <= $buffer_ref->[ $right ]->score
            ? $right
            : $left;

        @{ $buffer_ref }[ $cursor, $child ] = @{ $buffer_ref }[ $child, $cursor ]
            if $buffer_ref->[ $cursor ]->score <= $buffer_ref->[ $child ]->score;

        $cursor = $child;
    }

    return $last_root;
}
