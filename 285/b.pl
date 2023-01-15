#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{}, $l };

for my $i ( 0 .. $n - 2 ) {
    my $count = 0;

    my $j = 0;

    while ( $j + $i + 1 < $n ) {
        last
            if $s[ $j ] eq $s[ $j + $i + 1 ];
        $count++;
        $j++;
    }

    say $count;
}

exit;
