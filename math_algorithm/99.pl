#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $n = <> );
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n - 1;

my %links;

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    push @{ $links{ $u } }, $v;
    push @{ $links{ $v } }, $u;
}

my %count;

dfs( 1, 0 );

my $total = 0;

my @queue = map { [ $_, 1 ] } @{ $links{1} };

while ( @queue ) {
    my $ref = shift @queue;
    my( $u, $from ) = @{ $ref };
    my $descendants = $count{ $u } // 1;
    my $ancestors = $n - $descendants;
    my $passes = $descendants * $ancestors;
    $total += $passes;

    push @queue, map { [ $_, $u ] } grep { $_ != $from } @{ $links{ $u } };
}

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
}

say $total;

exit;

sub dfs {
    my $u = shift;
    my $parent = shift;

    return 1
        if @{ $links{ $u } } == 1 && $links{ $u }[0] == $parent;

    return $count{ $u } = 1 + sum( map { dfs( $_, $u ) } grep { $_ != $parent } @{ $links{ $u } } );
}
