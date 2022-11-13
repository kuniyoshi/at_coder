#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @p = do { chomp( my $l = <> ); split m{\s}, $l };

say grep { $p[ $_ - 1 ] == $x } 1 .. $n;

exit;
