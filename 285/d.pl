#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

my %links;

for my $ref ( @edges ) {
    my( $from, $to ) = @{ $ref };
    push @{ $links{ $from } }, $to;
}

my %name = map { $_ => $edges[ $_ ][0] } 0 .. $#edges;
my %index = reverse %name;

for my $ref ( @edges ) {
    my( $from, $to ) = @{ $ref };
    next
        if exists $index{ $to };
    $index{ $to } = %name;
    $name{ scalar %name } = $to;
}

my $tree = UnionFindTree->new( scalar %name );

for my $v ( 0 .. $n - 1 ) {
    for my $neighbor ( @{ $links{ $name{ $v } } } ) {
        $tree->unite( $v, $index{ $neighbor } );
    }
}

my %root;

for my $v ( 0 .. %name - 1 ) {
    $root{ $tree->root( $v ) }++;
}

say YesNo::get( test( ) );

exit;

sub test {
    for my $root ( keys %root ) {
        my @queue = @{ $links{ $name{ $root } } // [ ] };
        my %visited = ( $root => 1 );

        while ( @queue ) {
            my $name = shift @queue;
            return
                if $name eq $name{ $root };
            next
                if $visited{ $name }++;
            push @queue, grep { !$visited{ $_ } } @{ $links{ $name } };
        }
    }

    return 1;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;

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
