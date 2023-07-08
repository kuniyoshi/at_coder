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

my $passed = 0;

while ( $total > $k ) {
    die "No more ab"
        unless @ab;
    my $ab = shift @ab;
    $passed = $ab->[0];
    $total -= $ab->[1];
}

say $passed + 1;


exit;
