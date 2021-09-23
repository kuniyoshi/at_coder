#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $n = 300;
my $x = 300;
my $y = 300;

say $n;
say "$x $y";
say join( q{ }, ( int( $x * rand ), int( $y * rand ) ) )
    for 1 .. $n;

exit;

