#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @digits = reverse sort { $a <=> $b } split m{}, $n;

my $max = 0;

for ( my $i = 0; $i < 2 ** @digits; ++$i ) {
    my $l = 0;
    my $r = 0;

    for ( my $j = 0; $j < @digits; ++$j ) {
        if ( $i & ( 1 << $j ) ) {
            $l = $l * 10 + $digits[ $j ];
        }
        else {
            $r = $r * 10 + $digits[ $j ];
        }
    }

    $max = max( $max, $l * $r );
}

say $max;

exit;

sub max {
    my $a = shift;
    my $b = shift;
    return $b > $a ? $b : $a;
}
