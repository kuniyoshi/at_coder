#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum max );

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %count;
$count{ $_ }++
    for @a;

my @values = sort { $a <=> $b } keys %count;
my %index;
$index{ $values[ $_ ] } = $_
    for 0 .. $#values;

my $tree = UnionFindTree->new( scalar @values );

for my $a ( @a ) {
    my $neighbor = ( $a + 1 ) % $m;
    next
        unless exists $index{ $neighbor };

    die "no index found"
        if !defined $index{ $a } || !defined $index{ $neighbor };

    $tree->unite( $index{ $a }, $index{ $neighbor } );
}

#for my $i ( 0 .. $#values ) {
#    warn "$values[ $i ]: ", $tree->root( $i );
#}

my %sum;

for my $value ( @values ) {
    $sum{ $tree->root( $index{ $value } ) } += $value * $count{ $value };
}

my $max = max( values %sum );
my $total = sum( values %sum );

say $total - $max;

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
