#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $p, $q, $r, $s ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

$p--;
$q--;
$r--;
$s--;

my @b = ( @a[ 0 .. $p - 1 ], @a[ $r .. $s ], @a[ $q + 1 .. $r - 1 ], @a[ $p .. $q ], @a[ $s + 1 .. $#a ] );

say join q{ }, @b;

exit;
