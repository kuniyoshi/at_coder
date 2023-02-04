#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my @acc;
my $acc = 0;

for my $a ( @a ) {
    push @acc, $acc += $a;
}

for my $ref ( @queries ) {
    my( $l, $r ) = @{ $ref };
    $l--;
    $r--;
    my $sum = $acc[ $r ] - ( $l == 0 ? 0 : $acc[ $l - 1 ] );
    warn $sum;
}

exit;
