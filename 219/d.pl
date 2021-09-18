#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $xy = <> );
my @bentos = map { [ split m{\s} ] }
             map { chomp( my $l = <> ); $l }
             1 .. $n;

my( $x, $y ) = split m{\s}, $xy;

my( $total_x, $total_y ) = ( 0, 0 );

for my $bento_ref ( @bentos ) {
    $total_x = $total_x + $bento_ref->[0]
    $total_y = $total_y + $bento_ref->[1]
}

if ( $total_x < $x || $total_y < $y ) {
    say -1;
    exit;
}

exit;
