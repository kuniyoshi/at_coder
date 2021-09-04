#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $body = <> );
my @p = split m{\s}, $body;

my @q = ( );
$#q = $#p;

for my $i ( 0 .. $n - 1 ) {
    $q[ $p[ $i ] - 1 ] = $i + 1;
}

say join q{ }, @q;

exit;
