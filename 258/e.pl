#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $n, $q, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @w = do { chomp( my $l = <> ); split m{\s}, $l };
my @k = map { chomp; $_ }
        map { scalar <> }
        1 .. $q;

my @acc = 0;
for my $w ( @w ) {
    push @acc, $acc[-1] + $w;
}

my @counts;

my $max = max( @k );

my $cursor = 0;

for my $i ( 0 .. $max - 1 ) {

}

exit;
