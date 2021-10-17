#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );
my @s = split m{}, $s;
my $length = scalar @s;

my $min = join q{}, @s;
my $max = join q{}, @s;

for my $i ( 1 .. @s ) {
    my $top = shift @s;
    push @s, $top;
    my $new = join q{}, @s;

    $min = $new
        if $new lt $min;
    $max = $new
        if $new gt $max;
}

say $min;
say $max;

exit;
