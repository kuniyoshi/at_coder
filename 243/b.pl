#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = do { chomp( my $l = <> ); split m{\s}, $l };

my $x = 0;
my $y = 0;

for my $i ( 0 .. $#a ) {
    $x++
        if $a[ $i ] == $b[ $i ];
}

for my $i ( 0 .. $#a ) {
    for my $j ( 0 .. $#a ) {
        next
            if $j == $i;
        $y++
            if $a[ $i ] == $b[ $j ];
    }
}

say $x;
say $y;

exit;
