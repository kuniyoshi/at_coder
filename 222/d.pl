#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $line_a = <> );
chomp( my $line_b = <> );
my @a = ( 0, split m{\s}, $line_a );
my @b = ( 0, split m{\s}, $line_b );

my @previous = ( $a[0], $b[0] );
my @current = ( 0, 0 );
my $result = 1;

for my $i ( 2 .. $n ) { # die
    $current[0] = $a[ $i - 1 ];
    $current[1] = $b[ $i - 1 ];

    my $increment = 0;

    for my $j ( $previous[0] .. $previous[1] ) {
        my $candidate = $current[1] - $current[0] - $j + 2;
        warn "\$i: $i, \$j: $j, \$candidate: $candidate";
        die
            if $candidate < 0;
        $increment += $candidate;
    }

    $result = ( $result * $increment ) % 998244353;

    $previous[0] = $previous[1] > $current[0] ? $previous[1] : $current[0];
    $previous[1] = $current[1];
}

say $result;

exit;
