#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( first );

chomp( my $n = <> );
my( $sx, $sy, $tx, $ty ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @circles = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $n;

my $tree = UnionFindTree->new( scalar @circles );

for ( my $i = 0; $i < @circles; ++$i ) {
    for ( my $j = 0; $j < $i; ++$j ) {
        my $ri = $circles[ $i ][2];
        my $rj = $circles[ $j ][2];
        my $dx = $circles[ $i ][0] - $circles[ $j ][0];
        my $dy = $circles[ $i ][1] - $circles[ $j ][1];
        my $distance2 = $dx * $dx + $dy * $dy;

        next
            if $distance2 > ( ( $ri + $rj ) * ( $ri + $rj ) );

        next
            if ( ( ( $ri - $rj ) * ( $ri - $rj ) ) > $distance2 );

        $tree->unite( $i, $j );
    }
}

my( $from, $to );

for ( my $i = 0; $i < @circles; ++$i ) {
    my( $x, $y, $r ) = @{ $circles[ $i ] };

    if ( !defined $from && ( ( ( $sx - $x ) * ( $sx - $x ) + ( $sy - $y ) * ( $sy - $y ) ) == $r * $r ) ) {
        $from = $i;
    }

    if ( !defined $to && ( ( ( $tx - $x ) * ( $tx - $x ) + ( $ty - $y ) * ( $ty - $y ) ) == $r * $r ) ) {
        $to = $i;
    }

    last
        if defined $from && defined $to;
}

die "No **from** found"
    unless defined $from;
die "No **to** found"
    unless defined $to;

say YesNo::get( $tree->root( $from ) == $tree->root( $to ) );

exit;

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
