#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

say max( $a + $b, $a - $b, $a * $b );

exit;
