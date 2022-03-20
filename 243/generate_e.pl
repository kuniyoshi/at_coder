#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $n = 300;

my @linked;

my $count = $n / 2 * ( $n - 1 );

say "$n $count";

for my $i ( 0 .. $n - 1 ) {
    for my $j ( 0 .. $i - 1 ) {
        next
            if $linked[ $i ][ $j ]++;
        next
            if $linked[ $j ][ $i ]++;
        next
            if $j == $i;

        say sprintf "%d %d 1", $i + 1, $j + 1;
    }
}


exit;

