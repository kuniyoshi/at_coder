#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };
my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

@s[ $b - 1, $a - 1 ] = @s[ $a - 1, $b - 1 ];

say join q{}, @s;

exit;
