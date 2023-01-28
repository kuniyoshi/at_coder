#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;

my %links;

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    $u--;
    $v--;
    push @{ $links{ $u } }, $v;
    push @{ $links{ $v } }, $b;
}

my $one_count = 0;

for my $v ( 0 .. $n - 1 ) {
    my $count = @{ $links{ $v } // [ ] };
    next
        if $count == 2;
    next
        if $one_count++ < 2;
    say YesNo::get( 0 );
    exit;
}

if ( $one_count != 2 ) {
    say YesNo::get( 0 );
    exit;
}

my $tree = UnionFindTree->new( $n );

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    $u--;
    $v--;
    $tree->unite( $u, $v );
}

say YesNo::get( $tree->size( 0 ) == $n );

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

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
