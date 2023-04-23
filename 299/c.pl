#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
chomp( my $s = <> );

if ( $s !~ m{ [-] }msx ) {
    say -1;
    exit;
}

my @chunks = split q{-}, $s;

my @lengths = map { length } @chunks;

say max( @lengths ) // -1;

exit;
