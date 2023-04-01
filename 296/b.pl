#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = reverse
        map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. 8;

my @cols = ( "a" .. "h" );

for my $i ( 0 .. 7 ) {
    for my $j ( 0 .. 7 ) {
        next
            if $s[ $i ][ $j ] eq q{.};
        printf "%s%d\n", $cols[ $j ], $i + 1;
    }
}



exit;
