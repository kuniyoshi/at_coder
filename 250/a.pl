#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my( $r, $c ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $neighbors = 4;

$neighbors--
    if $r == 1;
$neighbors--
    if $r == $h;
$neighbors--
    if $c == 1;
$neighbors--
    if $c == $w;

say $neighbors;

exit;
