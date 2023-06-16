#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );

my $odds = grep { $_ % 2 } 1 .. $n;
say $odds / $n;

exit;
