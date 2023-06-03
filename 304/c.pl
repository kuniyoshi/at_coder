#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @people = map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. $n;

my $tree = UnionFindTree->new( $n );

my $d2 = $d * $d;

for ( my $i = 0; $i < $n; ++$i ) {
    for ( my $j = 0; $j < $i; ++$j ) {
        my $dx = $people[ $j ][0] - $people[ $i ][0];
        my $dy = $people[ $j ][1] - $people[ $i ][1];
        next
            if $dx * $dx + $dy * $dy > $d2;
        $tree->unite( $i, $j );
    }
}

for ( my $i = 0; $i < $n; ++$i ) {
    say YesNo::get( $tree->root( 0 ) == $tree->root( $i ) );
}

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
