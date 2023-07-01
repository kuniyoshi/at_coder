#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @c = do { chomp( my $l = <> ); split m{\s}, $l };
my @d = do { chomp( my $l = <> ); split m{\s}, $l };
my @p = do { chomp( my $l = <> ); split m{\s}, $l };

my %price;

for my $i ( 0 .. $m - 1 ) {
    $price{ $d[ $i ] } = $p[ $i + 1 ];
}

say sum( map { $price{ $_ } // $p[0] } @c );


exit;
