#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @ladders = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $n;

my %floor = ( 1 => 1 );

for my $ref ( @ladders ) {
    my( $bottom, $top ) = @{ $ref };
    $floor{ $bottom }++;
    $floor{ $top }++;
}

my @floors = sort { $a <=> $b } keys %floor;
my %index;
$index{ $floors[ $_ ] } = $_
    for 0 .. $#floors;

my $tree = UnionFindTree->new( scalar @floors );

for my $ref ( @ladders ) {
    my( $bottom, $top ) = @{ $ref };
    die "No index found"
        if !defined $index{ $bottom } || !defined $index{ $top };
    $tree->unite( $index{ $bottom }, $index{ $top } );
}

my $max = 1;
die "No index found"
    unless defined $index{1};
my $root = $tree->root( $index{1} );

for my $floor ( @floors ) {
    die "No index found"
        if !defined $index{ $floor };
    next
        if $tree->root( $index{ $floor } ) != $root;
    $max = max( $max, $floor );
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
