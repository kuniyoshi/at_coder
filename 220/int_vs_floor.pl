#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use POSIX qw( floor );
use Test::More tests => 6;

my $int1 = int( ( 2 ** 54 + 141 ) / 3 );
my $floor1 = floor( ( 2 ** 54 + 141 ) / 3 );
is( sprintf( "%d", $int1 ), sprintf( "%d", $floor1 ), "(2 ** 54 + 141 ) / 3" );

my $int2 = int( ( 2 ** 55 + 141 ) / 3 );
my $floor2 = floor( ( 2 ** 55 + 141 ) / 3 );
is( sprintf( "%d", $int2 ), sprintf( "%d", $floor2 ), "(2 ** 55 + 141 ) / 3" );

my $int3 = int( ( 2 ** 56 + 141 ) / 3 );
my $floor3 = floor( ( 2 ** 56 + 141 ) / 3 );
is( sprintf( "%d", $int3 ), sprintf( "%d", $floor3 ), "(2 ** 56 + 141 ) / 3" );

my $int4 = int( ( 2 ** 57 + 141 ) / 3 );
my $floor4 = floor( ( 2 ** 57 + 141 ) / 3 );
is( sprintf( "%d", $int4 ), sprintf( "%d", $floor4 ), "(2 ** 57 + 141 ) / 3" . ( 2 ** 57 + 141 ) / 3 );

my $int5 = 3 * int( ( 2 ** 54 + 141 ) / 3 );
my $floor5 = 3 * floor( ( 2 ** 54 + 141 ) / 3 );
is( sprintf( "%d", $int5 ), sprintf( "%d", $floor5 ), "3 * (2 ** 54 + 141 ) / 3" );

my $int6 = 3 * int( ( 2 ** 55 + 141 ) / 3 );
my $floor6 = 3 * floor( ( 2 ** 55 + 141 ) / 3 );
is( sprintf( "%d", $int6 ), sprintf( "%d", $floor6 ), "3 * (2 ** 55 + 141 ) / 3" . 3 * ( 2 ** 55 + 141 ) / 3 );

exit;
