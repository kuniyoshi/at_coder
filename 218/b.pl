#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $line = <> );
my @numbers = split m{\s}, $line;

say join q{}, map { chr( ord( q{a} ) + $_ - 1 ) } @numbers;

exit;
