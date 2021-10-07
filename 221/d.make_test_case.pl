#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $max_n = 10;
my $max_d = 10;
my $max_c = 10;

my @results = map { [ 1 + int $max_d * rand, 1 + int $max_c * rand ] }
              1 .. 1 + int $max_n * rand;

say scalar @results;
say
    for map { join q{ }, @{ $_ } }
    @results;

exit;

