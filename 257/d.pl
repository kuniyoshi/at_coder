#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max min );
use POSIX qw( ceil );

chomp( my $n = <> );
my @jumps = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

my $tree = UnionFindTree->new( $n );
my @distances;

for my $i ( 0 .. $n - 1 ) {
    for my $j ( 0 .. $n - 1 ) {
        my $p = ceil( ( abs( $jumps[ $j ][0] - $jumps[ $i ][0] ) + abs( $jumps[ $j ][1] - $jumps[ $i ][1] ) ) / $jumps[ $i ][2] );
        push @distances, [ $i - 1, $j - 1, $p ];
    }
}

@distances = sort { $a->[2] <=> $b->[2] } @distances;

my $max;

for my $i ( 0 .. $#distances ) {
    my $ref = $distances[ $i ];

    next
        if $tree->root( $ref->[0] ) == $tree->root( $ref->[1] );

    $max = max( $max // $ref->[2], $ref->[2] );

    $tree->unite( $ref->[0], $ref->[1] );
}

say $max;

exit;

package UnionFindTree;
use 5.10.0;
use utf8;
use strict;
use warnings;

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

1;
