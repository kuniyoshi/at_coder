#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $x, $y ) = do { chomp( my $l = <> ); split m{\s}, $l };
my $z = max( int( ( $y - $x ) / 10 ), 0 );
$z++
    if 10 * $z + $x < $y;
say $z;

exit;
