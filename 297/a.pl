#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @t = do { chomp( my $l = <> ); split m{\s}, $l };

for my $i ( 0 .. $n - 2 ) {
    if ( $t[ $i + 1 ] - $t[ $i ] <= $d ) {
        say $t[ $i + 1 ];
        exit;
    }
}

say -1;

exit;
