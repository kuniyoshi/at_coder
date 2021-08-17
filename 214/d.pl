#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my @edge_strings = <> );

my @edges = sort { $a->[2] <=> $b->[2] }
            map { [ split m{\s}, $_ ] }
            @edge_strings;

my $tree = UnionFindTree->new( 0 .. $n - 1 );

my $result = 0;

for my $edge_ref ( @edges ) {
    my( $n1, $n2, $cost ) = @{ $edge_ref };
    my( $u, $v ) = ( $n1 - 1, $n2 - 1 );

    $result = $result + $cost * $tree->size( $u ) * $tree->size( $v );

    $tree->unite( $u, $v );
}

say $result;

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
    my @vertexes = @_;
    my @sizes = ( 1 ) x @vertexes;
    return bless { parents => \@vertexes, sizes => \@sizes }, $class;
}
