#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $pi = "3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679";

chomp( my $n = <> );

say substr $pi, 0, $n + 2;

exit;
