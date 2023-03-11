#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };

say join q{}, map { $s[ $_ ], $s[ $_ - 1 ] } grep { $_ % 2 } 0 .. $#s;

exit;
