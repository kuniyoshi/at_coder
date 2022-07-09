#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $PI = 3.141592653589793238462643383739;

my( $a, $b, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $rad = $d * 2 * $PI / 360;

my $x = $a * cos( $rad ) - $b * sin( $rad );
my $y = $a * sin( $rad ) + $b * cos( $rad );

say "$x $y";

exit;
