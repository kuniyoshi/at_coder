#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @points = map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. $n;

my $xor = 0;

for my $ref ( @points ) {
    my( $a, $b ) = @{ $ref };
    $a--;
    $b--;
    $xor ^= $a;
    $xor ^= $b;
}

say $xor == 0 ? "Second" : "First";

exit;
