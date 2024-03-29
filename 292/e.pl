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

my @links;

for my $ref ( @edges ) {
    my( $from, $to ) = @{ $ref };
    push @{ $links[ $from ] }, $to;
}

my $total = 0;

for my $v ( 1 .. $n ) {
    my $count = 0;
    my %visited;
    my @queue = ( $v );

    while ( @queue ) {
        my $w = shift @queue;
        next
            if $visited{ $w }++;
        $count++;
        next
            unless $links[ $w ];
        push @queue, grep { !$visited{ $_ } } @{ $links[ $w ] };
    }

    $total += $count - 1;
}

say $total - $m;


exit;
