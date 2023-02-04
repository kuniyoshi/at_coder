#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; $_ }
        map { scalar <> }
        1 .. $n;

$#s = $k - 1;

say join qq{\n}, sort @s;

exit;
