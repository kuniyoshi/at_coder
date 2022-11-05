#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;

my %links;

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    push @{ $links{ $u } }, $v;
    push @{ $links{ $v } }, $u;
}

for my $i ( 1 .. $n ) {
    my @nodes = sort { $a <=> $b } @{ $links{ $i } // [ ] };
    say join q{ }, scalar( @nodes ), join q{ }, @nodes;
}

exit;
