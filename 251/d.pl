#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $w = <> );

my @numbers = (
    ( 1 .. 99 ),
    ( map { 100 * $_ } 1 .. 99 ),
    ( map { 10000 * $_ } 1 .. 99 ),
);

say scalar @numbers;
say join q{ }, @numbers;

exit;
