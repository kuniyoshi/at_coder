#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @c = do { chomp( my $l = <> ); split m{\s}, $l };

my @b;
$b[ $m ] = $c[ $n + $m ] / $a[ $n ];

for my $i ( reverse( 0 .. $n + $m - 1 ) ) {
    $c[ $i ] = 
    $b[ $i ] = ( $c[ $n + $i ] + $a[ $n + $m - $i - 1 ] * $b[ $i + 1 ] ) / $a[ $n + $m - $i ];
}

say join q{ }, @b;

exit;
