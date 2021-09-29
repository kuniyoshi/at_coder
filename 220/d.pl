#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $line = <> );
my @a = split m{\s}, $line;

my @patterns = ( undef ) x 10;
$patterns[ shift @a ]++;

while ( @a ) {
    my $y = shift @a;

    my @nexts = ( undef ) x 10;

    for ( my $i = 0; $i < @patterns; ++$i ) {
        next
            unless defined $patterns[ $i ];

        my $x = $i;
        my $f = ( $x + $y ) % 10;
        my $g = ( $x * $y ) % 10;
        $nexts[ $f ] = ( $nexts[ $f ] // 0 ) + $patterns[ $i ];
        $nexts[ $g ] = ( $nexts[ $g ] // 0 ) + $patterns[ $i ];
    }

    for ( my $i = 0; $i < 10; ++$i ) {
        $patterns[ $i ] = $nexts[ $i ];
    }
}

say $_ % 998244353
    for map { $_ // 0 } @patterns;

exit;
