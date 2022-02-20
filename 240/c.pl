#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @ab = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $n;

my @s;
my $sum = 0;

for my $ref ( @ab ) {
    my $diff = $ref->[1] - $ref->[0];
    $sum += $ref->[0];
    push @s, $diff;
}

$x = $x - $sum;

my @dp;
$dp[ $_ ][0]++
    for 0 .. ( $n - 0 );

for ( my $i = 0; $i < @s - 0; ++$i ) {
    for my $j ( 0 .. ( $x + 0 ) ) {
        $dp[ $i + 1 ][ $j ] ||= ( $j - $s[ $i ] >= 0 ) && $dp[ $i ][ $j - $s[ $i ] ];
        $dp[ $i + 1 ][ $j ] ||= $dp[ $i ][ $j ];
    }
}

say $dp[ $n - 0 ][ $x ] ? "Yes" : "No";

exit;
