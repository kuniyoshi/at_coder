#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $x = <> );

if ( $x < 40 ) {
    say 40 - $x;
    exit;
}

if ( $x < 70 ) {
    say 70 - $x;
    exit;
}

if ( $x < 90 ) {
    say 90 - $x;
    exit;
}

say "expert";

exit;
