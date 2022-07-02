#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $k = <> );

my $h = 21 + $k / 60;
my $m = $k % 60;

printf "%02d:%02d\n", $h, $m;

exit;
