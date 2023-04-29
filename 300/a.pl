#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @c = do { chomp( my $l = <> ); split m{\s}, $l };

my $answer = $a + $b;
my( $result ) = grep { $c[ $_ - 1 ] == $answer } 1 .. $n;
say $result;

exit;
