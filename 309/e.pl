#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my ( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @parents = do { chomp( my $l = <> ); split m{\s}, $l };
my @insurances = map { chomp; [ split m{\s} ] }
                 map { scalar <> } 1 .. $m;

my %children;

for my $i ( 0 .. $#parents ) {
    push @{ $children{ $parents[ $i ] } }, $i + 2;
}

# die Dumper \%children;

my %insurance;

for my $ref ( @insurances ) {
    my( $x, $y ) = @{ $ref };

    $insurance{ $x } = max( $y, $insurance{ $x } // 0 );
}

# die Dumper \%insurance;

dfs( 1, $insurance{1} // -1 );

# die Dumper \%insurance;

say scalar grep { $_ >= 0 } values %insurance;

exit;

sub dfs {
    my $person = shift;
    my $insurance = shift;

    $insurance{ $person } = max( $insurance, $insurance{ $person } // - 1 );

    for my $child ( @{ $children{ $person } } ) {
        dfs( $child, max( $insurance - 1, $insurance{ $child } // -1 ) );
    }
}

__END__

my @powers;
my $queue = PriorityQueue::PriorLarge->new;

for my $ref ( @insurances ) {
    my ( $x, $y ) = @{ $ref };
    $x--;

    $queue->push( [ $y, $x ] );
}

while ( $queue->size ) {
    my $ref = $queue->pop;
    my ( $p, $u ) = @{ $ref };
    if ( defined $powers[$u] && $powers[$u] > $p ) {
        next;
    }
    $powers[$u] = $p;
    next
      if $p == 0;
    for my $v ( @{ $link{ $u } // [] } ) {
        next
          if defined $powers[$v] && $powers[$v] >= $p - 1;
        $queue->push( [ $p - 1, $v ] );
    }
}

say scalar grep { defined } @powers;

exit;

use strict;
use warnings;

package PriorityQueue::PriorLarge;

sub new {
    my $class = shift;
    return bless { items => [] }, $class;
}

sub dump {
    my $self = shift;
    return join q{, }, @{ $self->{ items } };
}

sub push {
    my $self = shift;
    my $value = shift;
    Heap::push_to( $self->{ items }, $value );
}

sub pop {
    my $self = shift;

    die "Could not pop while buffer is empty"
      unless @{ $self->{ items } };

    return Heap::pop_from( $self->{ items } );
}

sub peek {
    return shift->{ items }[0];
}

sub size {
    return @{ shift->{ items } };
}

package Heap;

sub push_to {
    my ( $buffer_ref, $item ) = @_;

    push @{ $buffer_ref }, $item;

    my $cursor = $#{ $buffer_ref };

    while ( $cursor != 0 ) {
        my $parent = int( ( $cursor - 1 ) / 2 );
        @{ $buffer_ref }[ $parent, $cursor ] =
          @{ $buffer_ref }[ $cursor, $parent ]
          if $buffer_ref->[$parent][0] <= $buffer_ref->[$cursor][0];
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

        my $child =
             $right < @{ $buffer_ref }
          && $buffer_ref->[$left][0] <= $buffer_ref->[$right][0]
          ? $right
          : $left;

        @{ $buffer_ref }[ $cursor, $child ] =
          @{ $buffer_ref }[ $child, $cursor ]
          if $buffer_ref->[$cursor][0] <= $buffer_ref->[$child][0];

        $cursor = $child;
    }

    return $last_root;
}
