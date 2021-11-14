#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{\s}, $l };

my %candidate;

for my $a ( 1 .. 1000 ) {
    for my $b ( 1 .. 1000 ) {
        $candidate{ 4 * $a * $b + 3 * $a + 3 * $b }++;
    }
}

my $result = scalar grep { !$candidate{ $_ } } @s;
say $result;

exit;
