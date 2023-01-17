#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

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
    push @{ $links{ $v } }, $u;
}

my $tree = UnionFindTree->new( $n );

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    $u--;
    $v--;
    $tree->unite( $u, $v );
}

my %root_count = $tree->count;

my %color_count;

for my $root ( keys %root_count ) {
    my @queue = ( [ $root, 0 ] );
    my %color;
    my %count;
    my %visited;

    while ( @queue ) {
        my $ref = shift @queue;
        my( $v, $c ) = @{ $ref };
        if ( exists $color{ $v } && $color{ $v } != $c ) {
            say 0;
            exit;
        }
        next
            if $visited{ $v }++;
        $count{ $c }++;
        push @queue, map { [ $_, !$c ] } grep { !$visited{ $_ } } @{ $links{ $v } };
    }

    $color_count{ $root } = $count{0};
}

my $grand_total = sum( values %root_count );

my $total = 0;

for my $root ( keys %root_count ) {
    $total += ( $grand_total - $root_count{ $root } ) * $root_count{ $root };

}

say $total;

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
