#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $count = <> );
my @scores = split m{\s}, <>;

my( undef, $booby ) = sort { $b->[1] <=> $a->[1] }
                      map  { [ $_, $scores[ $_ ] ] }
                      0 .. $#scores;

my $index = $booby->[0];

say $index + 1;


exit;

