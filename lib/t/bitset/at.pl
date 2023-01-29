#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Bitset;
use Test::More;

plan tests => 4;

my $a = Bitset->new( 19 + 1 )->one;

is( $a->at( 0 ), 1 );

$a->shift_left( 2 );

is( $a->at( 0 ), 0 );
is( $a->at( 1 ), 0 );
is( $a->at( 2 ), 1 );


exit;

