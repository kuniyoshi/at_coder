#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Bitset;
use Test::More;

plan tests => 2;

my $a = Bitset->new( 19 + 1 )->one;

my $b = $a->clone;

for my $i ( 1 .. 3 ) {
    $b->shift_left( 2 );
    $a->or( $b );
    diag( $a->dump );
}

my $c = $a->clone;

for my $i ( 1 .. 6 ) {
    $c->shift_left( 5 );
    $a->or( $c );
    diag( $a->dump );
}

is( $a->dump, "10111101111011110101" );

is( $a->at( 19 ), 1 << 19 );

exit;

