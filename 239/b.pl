#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use integer;

chomp( my $x = <> );

my $base = $x / 10;
my $amari = $x % 10;

if ( $x < 0 ) {
    $base--
        if $amari;
    say $base;
}
else {
    say $base;
}

exit;

