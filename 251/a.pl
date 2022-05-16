#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );

my $length = length $s;
my $multiply = 6 / $length;

say $s x $multiply;

exit;
