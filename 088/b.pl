#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $n = <> );
my @a = sort { $b <=> $a } do { chomp( my $l = <> ); split m{\s}, $l };

my $alice = sum( map { $a[ $_ ] } grep { !( $_ % 2 ) } 0 .. $#a );
my $bob = sum( map { $a[ $_ ] } grep { $_ % 2 } 0 .. $#a );

say $alice - $bob;

exit;
