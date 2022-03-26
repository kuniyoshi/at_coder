#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b, $c, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $takahashi = sprintf "%02d:%02d:00", $a, $b;
my $aoki = sprintf "%02d:%02d:01", $c, $d;

say $takahashi le $aoki ? "Takahashi" : "Aoki";

exit;
