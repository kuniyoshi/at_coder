#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b, $c, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };
say( ( $a + $b ) * ( $c - $d ) );
say "Takahashi";

exit;
