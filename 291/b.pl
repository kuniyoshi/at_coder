#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $n = <> );
my @x = do { chomp( my $l = <> ); split m{\s}, $l };

my @scores = sort { $a <=> $b } @x;

say sum( @scores[ $n .. ( 4 * $n - 1 ) ] ) / ( 3 * $n );


exit;
