#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Test::More;
use Bitset;

plan tests => 2;

my $a = Bitset->new( 7 )->one;
$a->shift_left( 3 );
is( $a->dump, "0001000" );

my $b = $a->clone;
is( $b->dump, "0001000" );

exit;

