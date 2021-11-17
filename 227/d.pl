#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

use integer;

my $left = 0;
my $right = 1 + ( sum @a ) / $k;
my $center;

while ( $right - $left > 1 ) {
    $center = $left + ( $right - $left ) / 2;

    if ( is_true( $center ) ) {
        $left = $center;
    }
    else {
        $right = $center;
    }
}

say $left;

exit;

sub is_true {
    my $x = shift;

    my $sum = 0;

    for my $a ( @a ) {
        $sum = $sum + ( $a > $x ? $x : $a );
    }

    return $sum >= ( $x * $k );
}
