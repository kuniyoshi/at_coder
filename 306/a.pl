#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{}, $l };

say join q{}, map { ( $_ ) x 2 } @s;

exit;
