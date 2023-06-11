#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( first );

chomp( my $n = <> );

say first { $_ >= $n } map { 111 * $_ } 1 .. 9;



exit;
