#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $line = <> );
my( $s, $t ) = split m{\s}, $line;

my $count = 0;

for my $i ( 0 .. 100 ) {
    for my $j ( 0 .. 100 ) {
        for my $k ( 0 .. 100 ) {
            my $v = $i + $j + $k;
            my $w = $i * $j * $k;

            $count++
                if $v <= $s && $w <= $t;
        }
    }
}

say $count;

exit;
