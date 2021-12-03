#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );

my $t = "oxx" x 1e5;

my $index = index $t, $s;

say $index >= 0 ? "Yes" : "No";

exit;
