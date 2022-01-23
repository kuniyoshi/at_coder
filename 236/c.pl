#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $m, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = do { chomp( my $l = <> ); split m{\s}, $l };
my @t = do { chomp( my $l = <> ); split m{\s}, $l };

my %station;
$station{ $_ }++
    for @t;

print map { $_, "\n" }
      map { $station{ $_ } ? "Yes" : "No" }
      @s;

exit;
