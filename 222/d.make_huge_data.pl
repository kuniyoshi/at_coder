#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $n = 300;

say $n;
say join q{ }, ( 0 ) x $n;
say join q{ }, ( 3000 ) x $n;

exit;

