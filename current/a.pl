#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $s = <> );
my @weathers = split m{}, $s;

say $weathers[ $n - 1 ] eq q{o} ? "Yes" : "No";

exit;
