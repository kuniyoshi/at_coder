#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = map { chomp; $_ }
        map { scalar <> }
        1 .. $n;

my %count;

for my $s ( @s ) {
    $count{ join q{}, sort split m{}, $s }++;
}

my $total = 0;

for my $size ( values %count ) {
    next
        if $size == 1;
    $total += ( $size * ( $size - 1 ) ) / 2;
}

say $total;

exit;
