#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @cells = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

my %index;

for my $i ( 0 .. $#cells ) {
    my $ref = $cells[ $i ];
    $index{ $ref->[0] }{ $ref->[1] } = $i;
}

my $tree = UnionFindTree->new( scalar @cells );

my @neighbors = (
    [-1, -1],
    [-1, 0],
    [0, -1],
    [0, +1],
    [+1, 0],
    [+1, +1],
);

for my $i ( 0 .. $#cells ) {
    my( $x, $y ) = @{ $cells[ $i ] };

    for my $ref ( @neighbors ) {
        my $nx = $ref->[0] + $x;
        my $ny = $ref->[1] + $y;

        next
            unless exists $index{ $nx }{ $ny };

        $tree->unite( $i, $index{ $nx }{ $ny } );
    }
}

my %root;

for my $i ( 0 .. $#cells ) {
    $root{ $tree->root( $i ) }++;
}

say scalar keys %root;

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
