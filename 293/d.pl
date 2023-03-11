#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @abcd = map { chomp; [ split m{\s} ] }
           map { scalar <> }
           1 .. $m;

my %links;

for my $ref ( @abcd ) {
    my( $a, $b, $c, $d ) = @{ $ref };
    $a--;
    $c--;
    if ( $b eq q{B} ) {
        $a += $n;
    }
    if ( $d eq q{B} ) {
        $c += $n;
    }
    push @{ $links{ $a } }, $c;
    push @{ $links{ $c } }, $a;
}

for my $i ( 0 .. $n - 1 ) {
    my $j = $i + $n;
    push @{ $links{ $i } }, $j;
    push @{ $links{ $j } }, $i;
}

my $tree = UnionFindTree->new( 2 * $n );

for my $i ( 0 .. $n - 1 ) {
    for my $j ( @{ $links{ $i } // [ ] } ) {
        $tree->unite( $i, $j );
    }
}

for my $i ( 0 .. $n - 1 ) {
    $tree->unite( $i, $i + $n );
}

my %vetex_count;
my %edge_count;

for my $i ( 0 .. $n - 1 ) {
    my $root = $tree->root( $i );
    $vetex_count{ $root }++;
    $vetex_count{ $root }++;
    $edge_count{ $root } += @{ $links{ $i } // [ ] };
    $edge_count{ $root } += @{ $links{ $i + $n } // [ ] };
}

my $count = 0;

for my $root ( keys %vetex_count ) {
    $count++
        if $vetex_count{ $root } == $edge_count{ $root } / 2;
}

say $count, q{ }, %vetex_count - $count;

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
