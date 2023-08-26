#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $h, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @p = do { chomp( my $l = <> ); split m{\s}, $l };

my( $index ) = grep { $p[ $_ ] + $h >= $x } 0 .. $n - 1;

say $index + 1;

exit;
