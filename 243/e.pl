#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @l = sort { $a->[-1] <=> $b->[-1] }
        map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $m;

my $tree = UnionFindTree->new( $n );

my $skips = 0;

for my $edge_ref ( @l ) {
    my( $a, $b, $c ) = @{ $edge_ref };
    $a--;
    $b--;
    if ( $tree->root( $a ) == $tree->root( $b ) ) {
        $skips++;
        next;
    }
    $tree->unite( $a, $b );
}

warn Dumper $tree;
say $skips;

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
