#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $n1, $n2, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;

my %link;

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    $u--;
    $v--;

    push @{ $link{ $u } }, $v;
    push @{ $link{ $v } }, $u;
}


#say bfs( 0, sub { my $x = shift; $x < $n1 } ) + bfs( $n1 + $n2 - 1, sub { my $x = shift; $x >= $n1 } );
say 1 + bfs( 0 ) + bfs( $n1 + $n2 - 1 );


exit;

sub bfs {
    my $root = shift;
    #    my $test = shift;
    my %distance;

    my @queue = ( $root );
    $distance{ $root } = 0;

    while ( @queue ) {
        my $u = shift @queue;

        for my $v ( grep { !exists $distance{ $_ } } @{ $link{ $u } // [ ] } ) {
            $distance{ $v } = $distance{ $u } + 1;
            push @queue, $v;
        }
    }

    return max( values %distance );
}
