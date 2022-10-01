#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $n, $m, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;
my @paths = do { chomp( my $l = <> ); split m{\s}, $l };
my %connection;

for my $ref ( @edges ) {
    $connection{ $ref->[0] }{ $ref->[1] }++;
    $connection{ $ref->[1] }{ $ref->[0] }++;
}

my $cost = 0;
my $min = undef;
my $current = 1;
my %passes = ( 1 => 1 );

for my $i ( 0 .. $#paths ) {
    my( $u, $v, $c ) = @{ $edges[ $paths[ $i ] - 1 ] };

    if ( $u != $current ) {
        $current = 1;
        $cost = 0;
        %passes = ( );

        if ( $u == 1 ) {
            $cost = $c;
            %passes = ( $u => 1, $v => 1 );
            $current = $v;
        }

        next;
    }

    if ( $v == $n ) {
        $min = min( $min // $cost + $c, $cost + $c );
        $cost = 0;
        %passes = ( );
        $current = 1;
        next;
    }

    $current = $v;
    $cost += $c;
    $passes{ $u }++;
    $passes{ $v }++;
}

say $min // -1;

exit;
