#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum max min );

my( $n, $k, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

for my $a ( @a ) {
    next
        unless $k;
    next
        if $a < $x;

    my $using = min( $k, int( $a / $x ) );

    $k -= $using;
    die "too many use"
        if $k < 0;

    $a = $a - $using * $x;
}

@a = sort { $b <=> $a } @a;

for my $a ( @a ) {
    next
        unless $k;

    die "too large a"
        if $a >= $x;

    $a = 0;
    $k--;
}

say sum( @a );

exit;
