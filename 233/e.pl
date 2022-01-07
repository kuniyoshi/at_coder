#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use integer;

chomp( my $x = <> );
my @bits = split m{}, $x;
my @answers;

my @acc = ( 0 );
my $acc = 0;

for my $bit ( @bits ) {
    $acc = $acc + $bit;
    push @acc, $acc;
}

my $rise = 0;

for ( my $i = 0; $i < @bits; ++$i ) {
    my $sum = $acc[ @bits - $i ];
    my $total = $sum + $rise;
    my $bit = $total % 10;
    push @answers, $bit;
    $rise = int( $total / 10 );
}

push @answers, split m{}, $rise
    if $rise;

say join q{}, reverse @answers;

exit;
