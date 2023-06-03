#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use integer;

my( $a, $b, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };

if ( $a % $x ) {
    $a += $x;
    $a -= $a % $x;
}

$b -= $b % $x;

if ( $a > $b ) {
    say 0;
    exit;
}

say( ( $b - $a ) / $x + 1 );

exit;
