#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $l, $r ) = do { chomp( my $l = <> ); split m{\s}, $l };
$l--;
$r--;

my @chars = split m{}, "atcoder";

say join q{}, @chars[ $l .. $r ];

exit;
