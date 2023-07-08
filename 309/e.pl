#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @parents = do { chomp( my $l = <> ); split m{\s}, $l };
my @insurances = sort { $b->[1] <=> $a->[1] }
                 map { chomp; [ split m{\s} ] }
                 map { scalar <> }
                 1 .. $m;

my %link;

for my $i ( 0 .. $#parents ) {
    push @{ $link{ $parents[ $i ] - 1 } }, $i + 1;
}

my @powers;

for my $ref ( @insurances ) {
    my( $x, $y ) = @{ $ref };
    $x--;

    if ( defined $powers[ $x ] && $powers[ $x ] <= $y ) {
        next;
    }

    $powers[ $x ] = $y;
    my %distance;

    my @queue = ( $x );
    $distance{ $x } = 0;

    while ( @queue ) {
        my $u = shift @queue;

        next
            if $distance{ $u } == $y;

        for my $v ( grep { !exists $distance{ $_ } } @{ $link{ $u } // [ ] } ) {
            $distance{ $v } = $distance{ $u } + 1;
            $powers[ $v ] = $y - $distance{ $v };
            push @queue, $v;
        }
    }
}

say scalar grep { defined } @powers;

exit;
