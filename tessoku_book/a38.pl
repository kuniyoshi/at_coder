#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min sum );

my( $d, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @constraints = map { chomp; [ split m{\s} ] }
                  map { scalar <> }
                  1 .. $n;

my @times = ( 24 ) x $d;

for my $ref ( @constraints ) {
    my( $l, $r, $h ) = @{ $ref };
    for ( my $i = $l - 1; $i < $r; ++$i ) {
        $times[ $i ] = min( $times[ $i ], $h );
    }
}

say sum( @times );

exit;
