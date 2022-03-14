#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $v, $a, $b, $c ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $total = $a + $b + $c;

my $remain = $v % $total;

if ( $a > $remain ) {
    say "F";
    exit;
}

$remain = $remain - $a;

if ( $b > $remain ) {
    say "M";
    exit;
}

$remain = $remain - $b;

if ( $c > $remain ) {
    say "T";
    exit;
}

exit;
