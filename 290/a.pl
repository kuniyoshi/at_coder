#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = do { chomp( my $l = <> ); split m{\s}, $l };

say sum( @a[ map { $_ - 1 } @b ] );



exit;
