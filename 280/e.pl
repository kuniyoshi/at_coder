#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $p ) = do { chomp( my $l = <> ); split m{\s}, $l };
$p/=100;

my $d = 2 * $p + 1 - $p;
say $d;

exit;
