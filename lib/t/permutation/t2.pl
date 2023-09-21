#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Permutation;
use Test::More;

plan tests => 6;

my $permutation = Permutation->new( [ 1, 3, 8 ] );
my @expectations = (
    [ 1, 3, 8 ],
    [ 1, 8, 3 ],
    [ 3, 1, 8 ],
    [ 3, 8, 1 ],
    [ 8, 1, 3 ],
    [ 8, 3, 1 ],
);

while ( my $p = $permutation->next ) {
    is_deeply( $p, shift @expectations );
}

