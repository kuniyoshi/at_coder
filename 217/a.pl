#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $line = <> );
my( $s, $t ) = split m{\s}, $line;

say $s lt $t ? "Yes" : "No";

exit;
