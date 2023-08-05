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

my %link;

for my $ref ( @edges ) {
    my( $a, $b ) = @{ $ref };
    push @{ $link{ $b } }, $a;
}

my @candidates;

for my $i ( 1 .. $n ) {
    push @candidates, $i
        if !$link{ $i };
}

say @candidates == 1 ? $candidates[0] : -1;

exit;
