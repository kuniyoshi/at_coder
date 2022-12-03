#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @g = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

my $count = grep { $_ eq q{#} } map { @{ $_ } } @g;

say $count;

exit;
