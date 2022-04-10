#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $string_expression = <> );

my $number = eval "0b$string_expression";
my $new_value = $number >> 1;

printf "%04b\n", $new_value;

exit;
