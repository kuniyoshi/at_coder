#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = map { chomp; $_ }
        map { scalar <> }
        1 .. $n;

my %count;
$count{ $_ }++
    for @a;

say scalar keys %count;


exit;
