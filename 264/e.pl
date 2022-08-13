#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m, $e ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @l = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $e;
chomp( my $q = <> );
my @q = map { chomp( my $line = <> ); $line }
        1 .. $q;

my %dropped;
$dropped{ $_ - 1 }++
    for @q;

my @edges = map { $_->[1] }
            grep { !$dropped{ $_ } }
            map { [ $_, $l[ $_ ] ] }
            0 .. $#l;

my @links;

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    $u--;
    $v--;
    push @{ $links[ $u ] }, $v;
    push @{ $links[ $v ] }, $u;
}

my $tree = UnionFindTree->new( $n + $m );
my %connected_powers;

for my $power ( $n .. ( $n + $m - 1 ) ) {
    my %visited;
    my @queue = ( $power );

    while ( @queue ) {
        my $point = shift @queue;
        next
            if $visited{ $point }++;

        $tree->unite( $power, $point );
        push @{ $connected_powers{ $power } }, $point
            if $point >= $n;

        next
            unless defined $links[ $point ];

        push @queue, grep { !$visited{ $_ } } @{ $links[ $point ] };
    }
}

my $total = 0;
my %counted;

for my $power ( $n .. ( $n + $m - 1 ) ) {
    next
        if $counted{ $power }++;

    my @powers = @{ $connected_powers{ $power } // [ ] };

    $counted{ $_ }++
        for @powers;

    $total += $tree->size( $power ) - 1 - @powers;
}


say $total;


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
