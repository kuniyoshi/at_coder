#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use FenwickTree;
use Test::More;

plan tests => 5;

my $tree = FenwickTree->new( 5 );
$tree->add( $_ - 1, $_ )
    for 1 .. 5;

is( $tree->sum( 1 ), 1 );
is( $tree->sum( 2 ), 3 );
is( $tree->sum( 3 ), 6 );
is( $tree->sum( 4 ), 10 );
is( $tree->sum( 5 ), 15 );

exit;

