#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @times = do { chomp( my $l = <> ); split m{\s}, $l };

my @ovens = ( 0, 0 );

for my $require ( sort { $b <=> $a } @times ) {
    my $index = 0;

    for my $i ( 0 .. $#ovens ) {
        $index = $i
            if $ovens[ $i ] < $ovens[ $index ];
    }

    $ovens[ $index ] += $require;
}

say max @ovens;



exit;

