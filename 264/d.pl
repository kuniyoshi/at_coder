#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };

my $count = 0;

my @buffer = split m{}, "atcoder";

for my $i ( 0 .. $#buffer ) {
    my $char = $buffer[ $i ];
    my( $index ) = grep { $s[ $_ ] eq $char } 0 .. $#s;
    $count += $index - $i;
    splice @s, $index, 1;
    unshift @s, $char;
}

say $count;

exit;
