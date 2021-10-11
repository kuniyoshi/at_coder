#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $n = <> );
chomp( my $line_a = <> );
chomp( my $line_b = <> );
my @a = ( 0, split m{\s}, $line_a );
my @b = ( 0, split m{\s}, $line_b );

my @dp;
$dp[ $_ ] = [ ( 0 ) x 3001 ]
    for 0 .. $n;
$dp[0][0] = 1;

for my $i ( 1 .. $n ) {
    for my $j ( 0 .. 3000 ) {
        if ( is_in( $j, $a[ $i ], $b[ $i ] ) ) {
            my $sum = sum( @{ $dp[ $i - 1 ] }[ 0 .. $j ] );
            $dp[ $i ][ $j ] = $sum % 998244353;
        }
        else {
            $dp[ $i ][ $j ] = 0;
        }
    }
}

say sum( @{ $dp[ $n ] } ) % 998244353;

exit;

sub is_in {
    my $target = shift;
    my $min = shift;
    my $max = shift;
    return $target >= $min && $target <= $max;
}
