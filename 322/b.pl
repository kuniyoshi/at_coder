#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $m, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $s = <> );
chomp( my $t = <> );

my $is_prefix = $t =~ m{\A $s }msx ? 0 : 2;
my $is_suffix = $t =~ m{ $s \z}msx ? 0 : 1;

my $result = 3 & ( $is_prefix | $is_suffix );

say $result;

exit;
