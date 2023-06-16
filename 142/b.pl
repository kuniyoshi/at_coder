#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @h = do { chomp( my $l = <> ); split m{\s}, $l };

say scalar grep { $_ >= $k } @h;

exit;
