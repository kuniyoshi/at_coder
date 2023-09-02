#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m, $p ) = do { chomp( my $l = <> ); split m{\s}, $l };

$n -= $m;

my $count = $n >= 0;
$count += int( $n / $p )
    if $n >= 0;

say $count || 0;

exit;
