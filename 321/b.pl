#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min sum );

my( $n, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $min;

for my $last ( 0 .. 100 ) {
    my @candidates = sort { $a <=> $b } ( @a, $last );
    my $score = sum( @candidates[ 1 .. $#candidates - 1 ] );

    if ( $score >= $x ) {
        $min = min( $min // $last, $last );
    }
}

say $min // -1;

exit;
