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
    my $b = ceil( $m / $a ) + 0;
    next
        if $b > $n;
        #warn "f($a, $b) -> ", $a * $b;
    $min = min( $min, $a * $b );
}

say $min;

exit;
