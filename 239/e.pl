#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $q ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @x = do { chomp( my $l = <> ); split m{\s}, $l };
my @e = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. ( $n - 1 );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my @edges;

for my $ref ( @e ) {
    my( $from, $to ) = @{ $ref };
    $from--;
    $to--;
    push @{ $edges[ $from ] }, $to;
    push @{ $edges[ $to ] }, $from;
}

my @kth_maxes;

dfs( 0, -1 );

for my $query_ref ( @queries ) {
    my( $v, $k ) = @{ $query_ref };
    die "k is too large"
        if $k > @{ $kth_maxes[ $v - 1 ] };
    say $kth_maxes[ $v - 1 ][ $k - 1 ];
}

exit;

sub dfs {
    my $node = shift;
    my $parent = shift;

    my @maxes = ( $x[ $node ] );

    for my $candidate ( @{ $edges[ $node ] } ) {
        next
            if $candidate == $parent;
        my $child = $candidate;
        dfs( $child, $node );
        @maxes = sort { $b <=> $a } ( @maxes, @{ $kth_maxes[ $child ] } );
        $#maxes = 19
            if @maxes > 20;
    }

    $kth_maxes[ $node ] = \@maxes;
}
