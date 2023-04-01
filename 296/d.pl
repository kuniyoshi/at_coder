#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use POSIX qw( ceil );
use List::Util qw( min );

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $min = $n * $n;

if ( $min < $m ) {
    say -1;
    exit;
}

my $sqrt = min( ceil( sqrt( $m ) ), $m - 1 );

for my $a ( 1 .. $sqrt ) {
    my $ac = $n;
    my $wa = 1;

    while ( $ac - $wa > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $wj * $a >= $m ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    my $x = $a * $ac;
    next
        if $x < $m;
    $min = $x
        if $x < $min;
}

say $min;

exit;
