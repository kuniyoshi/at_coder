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

my $left = 1;
my $right = ( sum @a ) / $k;
my $center = 1;
my $answer = 1;

while ( $left < $right ) {
    $center = $left + ( $right - $left ) / 2;
    warn "### ($left, $center, $right)";
    warn "--- is_true: ", is_true( $center );

    if ( is_true( $center ) ) {
        $right = $center;
        $answer = $center;
    }
    else {
        $left = $center + 1;
    }
}

say $answer;

exit;

sub is_true {
    my $x = shift;

    my $max = $x * $k;
    my $sum = 0;

    for my $a ( @a ) {
        $sum = $sum + ( $a > $k ? $k : $a );
        return 1
            if $sum >= $max;
    }

    return;
}
