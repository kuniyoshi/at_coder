#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;


my $count = 0;

for my $i ( 0 .. $n - 1 ) {
    for my $j ( 0 .. $i - 1 ) {
        my %solved;

        $solved{ $_ }++
            for grep { $s[ $i ][ $_ ] eq q{o} } 0 .. $m - 1;
        $solved{ $_ }++
            for grep { $s[ $j ][ $_ ] eq q{o} } 0 .. $m - 1;

        $count++
            if scalar( %solved ) == $m;
    }
}

say $count;

exit;
