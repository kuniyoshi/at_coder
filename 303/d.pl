#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $x, $y, $z ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = do { chomp( my $l = <> ); split m{}, $l };

my $off = 0;
my $on = $z;

for my $i ( 0 .. $#s ) {
    $off += $s[ $i ] eq q{A} ? $y : $x;
    $on += $s[ $i ] eq q{A} ? $x : $y;

    $off = min( $off, $on + $z );
    $on = min( $on, $off + $z );
}

say min( $off, $on );

exit;
