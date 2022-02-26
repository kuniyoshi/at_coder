#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

say 1000;

for ( 0 .. 999 ) {
    say( ( q{.} ) x 1000 );
}

exit;

