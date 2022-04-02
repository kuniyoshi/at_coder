#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = do { chomp( my $l = <> ); split m{\s}, $l };
my @l = sort { $b->[1] <=> $a->[1] }
        map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $n;

exit;
