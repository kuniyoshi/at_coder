#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $n = 8;

my $length = 2 * $n;

say $n;

for ( my $i = 0; $i < $length - 1; ++$i ) {
    my $count = $length - $i - 1;
    say join q{ }, map { int( 16 * rand ) } 1 .. $count;
}


exit;

