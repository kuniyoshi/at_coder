#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $y = <> );

my %add = (
    2 => 0,
    3 => 3,
    0 => 2,
    1 => 1,
);

say $y + $add{ $y % 4 };

exit;
