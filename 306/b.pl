#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $result = 0;

for my $i ( 0 .. $#a ) {
    $result += $a[ $i ] * ( 1 << $i );
}

say $result;

exit;
