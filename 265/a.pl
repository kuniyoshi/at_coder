#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $x, $y, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };

if ( $x * 3 < $y ) {
    say $n * $x;
    exit;
}

my $threes = int( $n / 3 );
my $remain = $n - $threes * 3;

say $threes * $y + $remain * $x;

exit;
