#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @orders = map { $_->[0] + 1 }
             sort { $a->[1] <=> $b->[1] }
             map { [ $_, $a[ $_ ] ] }
             0 .. $#a;

say join q{ }, @orders;

exit;
