#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Bitset;
use Test::More;

plan tests => 1;

my $a = Bitset->new( 19 + 1 )->one;
$a->shift_left( 20 );
is( $a->dump, "00000000000000000000" );



exit;

