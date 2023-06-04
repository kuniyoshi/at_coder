#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

my( $k, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };

say join q{ }, max( -1000000, $x - $k + 1 ) .. min( 1000000, $x + $k - 1 );

exit;
