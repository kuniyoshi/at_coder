#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

for my $a ( 0 .. 3 ) {
    for my $b ( 0 .. 3 ) {
        my $x = $a ** 3 + $a ** 2 * $b + $a * $b ** 2 + $b ** 3;
        say "f($a, $b) = $x";
    }
}

126481787415392
999999999989449206



exit;

