#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @c = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp;
$dp[ $n - 1 + $m - 1 ] = $c[-1] / $a[-1];

for my $i ( reverse( 0 .. $n + $m - 1 ) ) {

}

say join q{ }, @dp;

exit;
