#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $n, $m, $x, $t, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $from = $t - min( $n, $x ) * $d;
my $to = min( $m, $x );

say $from + $to * $d;



exit;
