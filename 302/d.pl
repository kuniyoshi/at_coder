#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $n, $m, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = sort { $a <=> $b } do { chomp( my $l = <> ); split m{\s}, $l };

my $max = -1;

for my $a ( @a ) {
    if ( $a <= $b[0] ) {
        next
            if $b[0] - $a > $d;
        $max = max( $max, $b[0] - $a );
        next;
    }
    elsif ( $a >= $b[-1] ) {
        next
            if $a - $b[-1] > $d;
        $max = max( $max, $a - $b[-1] );
        next;
    }

    my $index = a( $a );

    my $cand = b( $a, $index );

    if ( defined $cand ) {
        $max = max( $max, abs( $b[ $cand ] - $a ) );
    }

    my $cand2 = b2( $a, $index );

    if ( defined $cand2 ) {
        $max = max( $max, abs( $b[ $cand2 ] - $a ) );
    }
}

say $max;

exit;

sub b2 {
    my $a = shift;
    my $index = shift;

    my $x = $a + $d;
    return $#b
        if $x >= $b[-1];
    my $ac = $index;
    my $wa = $#b;
    while ( $ac - $wa > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $b[ $wj ] <= $x ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }
    return $ac;
}

sub b {
    my $a = shift;
    my $index = shift;

    my $x = $a - $d;
    return 0
        if $x <= $b[0];
    my $ac = $index;
    my $wa = 0;
    while ( $ac - $wa > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $b[ $wj ] >= $x ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }
    return $ac;
}

sub a {
    my $a = shift;
    die "could not found"
        if $b[0] > $a;
    die "could not found"
        if $b[-1] < $a;
    my $ac = 0;
    my $wa = $#b;

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $b[ $wj ] <= $a ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    return $ac;
}
