#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

shift @a
    for 1 .. min( $k, $n );

push @a, 0
    for 1 .. min( $k, $n );

say join q{ }, @a;

exit;
