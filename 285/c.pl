#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };

my $number = 0;
my $base = 0;

my %value = map { $_ => ord( $_ ) - 64 } "A" .. "Z";

while ( @s ) {
    my $char = pop @s;
    my $unit = 26 ** $base;

    $number += $value{ $char } * $unit;

    $base++;
}

say $number;


exit;
