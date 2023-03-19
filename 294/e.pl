#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $l, $n1, $n2 ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $n1;
my @b = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $n2;

my $cursor = 0;
my $total = 0;

while ( $cursor < $l ) {
    die "No data"
        if !@a || !@b;
    my $step = min( $a[0][1], $b[0][1] );
    $total += $step
        if $a[0][0] == $b[0][0];
    $cursor += $step;
    $a[0][1] -= $step;
    $b[0][1] -= $step;
    shift @a
        unless $a[0][1];
    shift @b
        unless $b[0][1];
}

say $total;

exit;
