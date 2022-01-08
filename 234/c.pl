#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $k = <> );

my @digits = map { $_ ? 2 : 0 }
             split m{}, sprintf "%b", $k;

say join q{}, @digits;

exit;
