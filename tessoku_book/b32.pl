#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp = ( 0 ) x ( $n + 1 );

for ( my $i = 0; $i < $n + 1; ++$i ) {
    for ( my $j = 0; $j < $k; ++$j ) {
        if ( $i >= $a[ $j ] && !$dp[ $i - $a[ $j ] ] ) {
            $dp[ $i ]++;
        }
    }
}

say $dp[ $n ] ? "First" : "Second";

exit;
