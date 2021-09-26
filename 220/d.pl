#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $line = <> );
my @a = split m{\s}, $line;

my @f = ( 0 ) x 10;
my @g = ( 0 ) x 10;

for my $i ( 1 .. $n - 1 ) {
    my $x = shift @a;
    my $y = shift @a;
    my $f = ( $x + $y ) % 10;
    my $g = ( $x * $y ) % 10;
    $
}

say $f[ $_ ] % 998244353 + $g[ $_ ] % 998244353
    for 0 .. 9;

exit;
