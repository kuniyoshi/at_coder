#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( first sum );

chomp( my $n = <> );
my @times = do { chomp( my $l = <> ); split m{\s}, $l };

my $total = sum( @times );

my @dp = ( [ 0 ] );

for ( my $i = 0; $i < @times; ++$i ) {
    for ( my $j = 0; $j <= $total; ++$j ) {
        next
            unless defined $dp[ $i ][ $j ];

        $dp[ $i + 1 ][ $j ]++;
        $dp[ $i + 1 ][ $j + $times[ $i ] ]++;
    }
}

my $answer = first { defined $dp[-1][ $_ ] && $_ > ( $total / 2 ) } 0 .. $total;

say $answer;


exit;

