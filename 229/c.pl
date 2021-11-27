#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $n, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @cheeses = sort { $b->[0] <=> $a->[0] }
              map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $n;

my $score = 0;
my $weight = 0;

while ( $weight < $w && @cheeses ) {
    my $cheese_ref = shift @cheeses;
    my $take = min( $w - $weight, $cheese_ref->[1] );
    $weight = $weight + $take;
    $score = $score + $take * $cheese_ref->[0];
}

say $score;

exit;
