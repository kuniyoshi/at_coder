#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @v = map { chomp; [ split m{\s} ] }
        map { <> }
        1 .. $n;

my $count = 0;

for my $i ( 0 .. $n - 1 ) {
    for my $j ( 0 .. $i - 1 ) {
        for my $k ( 0 .. $j - 1 ) {
            my $ax = $v[ $i ][0] - $v[ $j ][0];
            my $ay = $v[ $i ][1] - $v[ $j ][1];
            my $bx = $v[ $i ][0] - $v[ $k ][0];
            my $by = $v[ $i ][1] - $v[ $k ][1];
            my $det = $ax * $by - $ay * $bx;
            $count++
                if $det != 0;
        }
    }
}

say $count;

exit;
