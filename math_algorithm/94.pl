#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min sum );

chomp( my $n = <> );
my @b = do { chomp( my $l = <> ); split m{\s}, $l };
push @b, $b[-1];
my @a;

$a[0] = $b[0];

for my $i ( 1 .. $n - 1 ) {
    $a[ $i ] = min( $b[ $i - 1 ], $b[ $i ] );
}

say sum( @a );

exit;

