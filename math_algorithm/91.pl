#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $x ) = do { chomp( my $l = <> ); split m{ }, $l };

my $count = 0;

for my $i ( 1 .. $n ) {
    for my $j ( $i + 1 .. $n ) {
        for my $k ( $j + 1 .. $n ) {
            $count++
                if $i + $j + $k == $x;
        }
    }
}

say $count;


exit;

