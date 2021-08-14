#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );

my @a = ( 4 ) x 125;
my @b = ( 6 ) x ( 211 - 126 + 1 );
my @c = ( 8 ) x ( 214 - 212 + 1 );

my @all = ( @a, @b, @c );
warn scalar @all;
my $index = $n - 1;

say $all[ $index ];


exit;
