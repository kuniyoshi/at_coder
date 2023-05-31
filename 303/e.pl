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
            1 .. ( $n - 1 );

my %link;
my %degree;

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };

    $link{ $u }{ $v }++;
    $link{ $v }{ $u }++;

    $degree{ $u }++;
    $degree{ $v }++;
}

my $leaf = leaf( %degree );
my %star;

dfs( $leaf, undef, 0 );

say join q{ }, map { ( $_ ) x $star{ $_ } } sort { $a <=> $b } keys %star;

exit;

sub dfs {
    my $v = shift;
    my $parent = shift;
    my $distance = shift;

    for my $u ( keys %{ $link{ $v } // { } } ) {
        next
            if defined $parent && $u == $parent;
        if ( ( $distance + 1 ) % 3 == 1 ) {
            $star{ $degree{ $u } }++;
        }
        dfs( $u, $v, $distance + 1 );
    }
}

sub leaf {
    my %degree = @_;
    for my $v ( 1 .. $n ) {
        return $v
            if $degree{ $v } && $degree{ $v } == 1;
    }
    die "Could not find leaf";
}
