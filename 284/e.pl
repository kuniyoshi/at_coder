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

my @queue = ( [ 1 ] );
my $count = 1;
my %passed = ( 1 => 1 );

while ( @queue ) {
    my $ref = shift;
    my $v = shift @queue;
    next
        if $passed{ $v }++;
    $count++;
    for my $w ( @{ $links{ $v } } ) {
        unshift @queue, $w;
    }
    last
        if $count == 1e6;
}

say $count;

exit;

sub dfs {
    my $v = shift;
    my $c = shift;
    return $c
        if $c == 1e6;

}

sub bfs {
    my @queue = ( [ 1, { 1 => 1 } ] );
    my $count = 1;

    while ( @queue ) {
        my $ref = shift @queue;
        my $v = $ref->[0];
        for my $w ( @{ $links{ $v } } ) {
            next
                if $ref->[1]{ $w };
            my %passed = %{ $ref->[1] };
            $passed{ $w }++;
            push @queue, [ $w, \%passed ];
            $count++;
            return 1e6
                if $count >= 1e6;
        }
    }

    return $count;
}
