#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @g = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

my $tree = UnionFindTree->new( $h * $w );

my @moves = (
    [ 1, 1 ],
    [ 1, -1 ],
    [ -1, -1 ],
    [ -1, 1 ],
);

for my $i ( 0 .. $h - 1 ) {
    for my $j ( 0 .. $w - 1 ) {
        next
            unless $g[ $i ][ $j ] eq q{#};

        for my $ref ( @moves ) {
            my( $di, $dj ) = @{ $ref };
            next
                if $i + $di < 0 || $i + $di >= $h || $j + $dj < 0 || $j + $dj >= $w;
            next
                if $g[ $i + $di ][ $j + $dj ] ne q{#};

            $tree->unite( $i * $w + $j, ( $i + $di ) * $w + $j + $dj );
        }
    }
}

my %count = $tree->count;
my @counts = ( 0 ) x min( $h, $w );

for my $size ( values %count ) {
    next
        if $size == 1;
    my $x = $size - 1;
    $counts[ ( $x / 4 ) - 1 ]++;
}

say join q{ }, @counts;

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
