#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. 10;

my $min;
my $max;

for my $i ( 0 .. 9 ) {
    for my $j ( 0 .. 9 ) {
        next
            unless $s[ $i ][ $j ] eq q{#};
        $min //= [ $i, $j ];
        $max = [ $i, $j ];
    }
}

die "Could not get min"
    unless $min;
die "Could not get max"
    unless $max;


my $a = $min->[0] + 1;
my $b = $max->[0] + 1;
my $c = $min->[1] + 1;
my $d = $max->[1] + 1;

say "$a $b\n$c $d";

exit;
