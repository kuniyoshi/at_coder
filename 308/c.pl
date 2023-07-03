#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use integer;

chomp( my $n = <> );
my @ab = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $n;

my @indexes = map { $_->[0] }
              sort { $b->[1][0] * ( $a->[1][0] + $a->[1][1] ) <=> $a->[1][0] * ( $b->[1][0] + $b->[1][1] ) }
              map { [ $_, $ab[ $_ ] ] }
              0 .. $#ab;

say join q{ }, map { $_ + 1 } @indexes;

exit;
