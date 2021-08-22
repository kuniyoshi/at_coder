#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use bigint;

chomp( my $n = <> );

my $k = 0;
$k++
    while ( 2 ** $k ) <= $n;

say $k - 1;
