#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $m;

my %is_friend;

for my $i ( 0 .. $m - 1 ) {
    for my $j ( 0 .. $n - 2 ) {
        $is_friend{ $a[ $i ][ $j ] }{ $a[ $i ][ $j + 1 ] }++;
        $is_friend{ $a[ $i ][ $j + 1 ] }{ $a[ $i ][ $j ] }++;
    }
}

my $count = 0;

for my $i ( 0 .. $n - 1 ) {
    for my $j ( 0 .. $i - 1 ) {
        next
            if $is_friend{ $i + 1 }{ $j + 1 };
        $count++;
    }
}

say $count;

exit;
