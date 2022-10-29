#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @h = do { chomp( my $l = <> ); split m{\s}, $l };

my( $index ) = map { $_->[1] }
               sort { $b->[0] <=> $a->[0] }
               map { [ $h[ $_ ], $_ ] }
               0 .. $#h;

say $index + 1;


exit;
