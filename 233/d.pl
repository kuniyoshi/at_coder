#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $acc = 0;
my @acc;

for ( my $i = 0; $i < @a; ++$i ) {
    $acc = $acc + $a[ $i ];
    $acc[ $i ] = $acc;
}

exit;
