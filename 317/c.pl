#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );
use Memoize;

memoize( "dfs" );

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;

my %distance;

for my $ref ( @edges ) {
    my( $u, $v, $c ) = @{ $ref };
    $u--;
    $v--;
    $distance{ $u }{ $v } = $c;
    $distance{ $v }{ $u } = $c;
}

#say dfs( 0, 3, 0 );

say max( map { dfs( 0, $_, 0 ) } 0 .. $n - 1 );

exit;

sub dfs {
    my $passed = shift;
    my $current = shift;
    my $total = shift;
    #    warn sprintf "(%b, %d, %d)", $passed, $current, $total;

    die "$current passed already"
        if $passed & ( 1 << $current );

    $passed |= 1 << $current;
    my $neighbor = 0;

    for my $u ( keys %{ $distance{ $current } } ) {
        next
            if $passed & ( 1 << $u );
        $neighbor = max( $neighbor, dfs( $passed, $u, $distance{ $current }{ $u } ) );
    }

    return $total + $neighbor;
}
