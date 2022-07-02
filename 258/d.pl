#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $n, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @stages = map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. $n;

my $min;
my $previous = 0;
my $remain = $x;

for my $ref ( @stages ) {
    my( $story, $game ) = @{ $ref };

    $previous += $story + $game;
    $remain--;

    last
        if $remain == 0;

    my $loop = $previous + $game * $remain;
    $min = min( $min // $loop, $loop );
}

say $min;

exit;
