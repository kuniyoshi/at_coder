#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $head = <> );
my( $h, $w ) = split m{\s}, $head;
my @v = map { chomp; [ split m{\s} ] }
        map { <> }
        1 .. $h;

for my $i ( 0 .. $h - 2 ) {
    for my $j ( 0 .. $w - 2 ) {
        for my $k ( $i + 1 .. $h - 1 ) {
            for my $l ( $j + 1 .. $w - 1 ) {
                if ( $v[ $i ][ $j ] + $v[ $k ][ $l ] > $v[ $k ][ $j ] + $v[ $i ][ $l ] ) {
                    say "No";
                    exit;
                }
            }
        }
    }
}

say "Yes";

exit;
