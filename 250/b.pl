#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $color;

for my $i ( 1 .. $n ) {
    for my $j ( 1 .. $a ) {
        for my $x ( 1 .. $n ) {
            $color = ( ( $i + $x ) % 2 ) == 0 ? q{.} : q{#};

            for my $y ( 1 .. $b ) {
                print $color;
            }
        }
        print "\n";
    }
}

exit;
