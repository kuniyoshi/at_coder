#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Test::More;
use Bitset;

plan tests => 3;

my $a = Bitset->new( 7 )->one;
is( $a->dump, "0000001" );

my $b = Bitset->new( 7 )->one;
$b->shift_left( 2 );
is( $b->dump, "0000100" );

$a->or( $b );

is( $a->dump, "0000101" );

exit;

