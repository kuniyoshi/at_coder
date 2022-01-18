#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m, $q ) = split m{\s}, <>;
my @edges = sort { $a->[2] <=> $b->[2] }
            map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

use sort "stable";
my @indexes = sort { $queries[ $a ][2] <=> $queries[ $b ][2] }
              0 .. ( $q - 1 );
my @answers;

my $union_find_tree = UnionFindTree->new( $n );

for my $edge_ref ( @edges ) {
    my( $u, $v, $weight ) = @{ $edge_ref };
    $u--;
    $v--;

    while ( @indexes && $weight > $queries[ $indexes[0] ][2] ) {
        my $index = shift @indexes;
        my( $x, $y, undef ) = @{ $queries[ $index ] };
        $x--;
        $y--;
        push @answers, $union_find_tree->root( $x ) == $union_find_tree->root( $y )
            ? "No"
            : "Yes";
    }

    next
        if $union_find_tree->root( $u ) == $union_find_tree->root( $v );

    $union_find_tree->unite( $u, $v );
}

for my $index ( @indexes ) {
    my( $u, $v, undef ) = @{ $queries[ $index ] };
    $u--;
    $v--;
    push @answers, $union_find_tree->root( $u ) == $union_find_tree->root( $v )
        ? "No"
        : "Yes";
}

print map { $_, "\n" } @answers;

exit;

package UnionFindTree;

sub size {
    my $self = shift;
    my $u = shift;
    return $self->{sizes}[ $self->root( $u ) ];
}

sub unite {
    my $self = shift;
    my( $u, $v ) = @_;
    my( $root_u, $root_v ) = ( $self->root( $u ), $self->root( $v ) );

    return
        if $root_u == $root_v;

    my( $size_u, $size_v ) = @{ $self->{sizes} }[ $root_u, $root_v ];
    $self->{sizes}[ $root_v ] = $size_u + $size_v;
    $self->{sizes}[ $root_u ] = $size_u + $size_v;
    $self->{parents}[ $root_u ] = $root_v;
}

sub root {
    my $self = shift;
    my $v = shift;
    my $parent = $self->{parents}[ $v ];

    return $v
        if $parent == $v;

    return $self->{parents}[ $v ] = $self->root( $parent );
}

sub new {
    my $class = shift;
    my $n = shift;
    my @sizes = ( 1 ) x $n;
    return bless { parents => [ 0 .. ( $n - 1 ) ], sizes => \@sizes }, $class;
}
