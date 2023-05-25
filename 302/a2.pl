#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use bigint;

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

say int( ( $a + $b + 1 ) / $b );

exit;
