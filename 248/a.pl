#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );
my @numbers = split m{}, $s;
my %count;
$count{ $_ }++
    for @numbers;

say grep { !defined $count{ $_ } } 0 .. 9;

exit;
