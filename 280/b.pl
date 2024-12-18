#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{\s}, $l };

my @a;

my $a = 0;
my $total = 0;

for my $s ( @s ) {
    $a = $s - $total;
    push @a, $a;
    $total += $a;
}

say join q{ }, @a;

exit;
