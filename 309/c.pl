#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @ab = sort { $a->[0] <=> $b->[0] }
         map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $n;

my $total = sum( map { $_->[1] } @ab );

if ( $total <= $k ) {
    say 1;
    exit;
}

my $passed = 0;

for my $ab ( @ab ) {
    $passed = $ab->[0];
    $total -= $ab->[1];

    last
        if $total <= $k;
}

say $passed + 1;


exit;
