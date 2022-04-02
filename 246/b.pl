#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };
my $c = sqrt( $a * $a + $b * $b );

printf "%.8f %.8f\n", $a / $c, $b / $c;

exit;
