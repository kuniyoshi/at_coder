#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k, $l ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @roads = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $k;
my @rails = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $l;

my $road = UnionFindTree->new( $n );
my $rail = UnionFindTree->new( $n );

for my $ref ( @roads ) {
    my( $u, $v ) = @{ $ref };
    $u--;
    $v--;
    $road->unite( $u, $v );
}

for my $ref ( @rails ) {
    my( $u, $v ) = @{ $ref };
    $u--;
    $v--;
    $rail->unite( $u, $v );
}

my %count;

for my $v ( 0 .. $n - 1 ) {
}

say join q{ }, map { $tree->size( $_ ) } 0 .. $n - 1;

exit;

package UnionFindTree;
use 5.10.0;
use utf8;
use strict;
use warnings;

sub count {
    my $self = shift;
    my %count;
    $count{ $_ }++
        for map { $self->root( $_ ) }
            0 .. $#{ $self->{sizes} };
    return %count;
}

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
