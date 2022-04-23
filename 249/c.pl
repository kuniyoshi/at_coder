#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] } //
        map { scalar <> }
        1 .. $n;

my @dp;

for my $i ( 1 .. $n - 1 ) {
    for my $j ( 0 .. $k - 1 ) {
        $dp[ $i ][ $j ] = max( $dp[ $i - 1 ][ $j ], $dp[ $i ][ $j ] );
        $dp[ $i ][ $j ] = max( $dp[ $i ][ $j ], $dp[ $i - 1 ][ $j - 1 ] )
            if $j > 0;
    }
}

say scalar grep { $_ > 0 } @{ $dp[ $n - 1 ][ $k - 1 ] };

exit;

sub max {
}
