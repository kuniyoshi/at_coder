#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );

my $max_exclusive = 2 ** 31;
my $min_inclusive = -( 2 ** 31 );

my $is = $n >= $min_inclusive && $n < $max_exclusive;

say $is ? "Yes" : "No";


exit;
