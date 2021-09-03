#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $depth = 10;
my $n = 2e5;
my $m = 2e5 / $depth;

say "$n $m";

my @balls_a = 1 .. $n;
my @balls_b = 1 .. $n;

for my $i ( 1 .. $m / 2 ) {
    say $depth;
    say join q{ }, map { shift @balls_a } 1 .. $depth;
    say $depth;
    say join q{ }, map { shift @balls_b } 1 .. $depth;
}

exit;

