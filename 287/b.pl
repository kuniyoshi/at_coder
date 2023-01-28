#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; $_ }
        map { scalar <> }
        1 .. $n;
my @t = map { chomp; $_ }
        map { scalar <> }
        1 .. $m;

my $count = 0;

for my $s ( @s ) {
    $count++
        if grep { $s =~ m{\Q$_\E \z}msx } @t;
}

say $count;

exit;
