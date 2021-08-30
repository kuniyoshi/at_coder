#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $line = <> );
my( $x, $y ) = split m{\.}, $line;

my @r = (
    ( "$x-" ) x 3,
    ( "$x" ) x 4,
    ( "$x+" ) x 3,
);

say $r[ $y ];

exit;
