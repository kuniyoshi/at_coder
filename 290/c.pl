#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %is;
$is{ $_ }++
    for @a;

my $mex = 0;

for ( my $i = 0; $i < $k; ++$i ) {
    last
        unless $is{ $i };

    $mex++;
}

say $mex;

exit;
