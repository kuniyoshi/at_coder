#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $n = <> );

my $p = int( sqrt( sqrt( $n ) ) );
$p++
    while 4 * $p ** 3 < $n;
$p--;

my @points = ( [ $p, $p ], [ $p + 1, $p ], [ $p + 1, $p + 1 ], [ $p + 1, $p + 1 ] );

my $answer = min( grep { $_ >= $n } map { f( $_ ) } @points );

say $answer;

exit;

sub f {
    my( $a, $b ) = @{ shift( ) };
    my $x = $a ** 3 + $a ** 2 * $b + $a * $b ** 2 + $b ** 3;
    warn "\$x: $x";
    return $x;
}
