#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @A = do { chomp( my $l = <> ); split m{\s}, $l };

my $index = -1;

( $index ) = map { $_->[0] }
             map { warn Dumper $_; $_ }
             grep { $_->[1] == 0 }
             map { warn Dumper $_; $_ }
             map { [ $_, $A[ $_ ] ] }
             0 .. $#A;
die;
die "No zero found"
    if $index == -1;

warn "\$index: $index";
my $d1 = $A[ $index ];
say "\$d1: $d1";
$index = $d1;
my $d2 = $A[ $index ];
say "\$d2: $d2";
$index = $d2;
my $d3 = $A[ $index ];

say $d3;

exit;
