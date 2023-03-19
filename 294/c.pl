#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = do { chomp( my $l = <> ); split m{\s}, $l };

my @c = sort { $a <=> $b } ( @a, @b );
my %index;
$index{ $c[ $_ ] } = $_
    for 0 .. $#c;

say join q{ }, map { $index{ $_ } + 1 } @a;
say join q{ }, map { $index{ $_ } + 1 } @b;

exit;
