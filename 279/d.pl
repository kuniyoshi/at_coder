#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $n = bin( $a, $b );

say calc( $n, $a, $b );

exit;

sub t {
    my $n = shift;
    my $a = shift;
    my $b = shift;

    my $y0 = calc( $n, $a, $b );
    my $y1 = calc( $n + 1, $a, $b );
    my $t = $y1 - $y0;
    #my $t = $b + $a / sqrt( $n + 2 ) - $a / sqrt( $n + 1 );

    return $t;
}

sub bin {
    my $a = shift;
    my $b = shift;
    return 0
        if t( 0, $a, $b ) >= 0;
    my $wa = 1e12;
    my $ac = 0;

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $wa + $ac ) / 2 );
        #warn "\$wj: $wj";
        my $t = t( $wj, $a, $b );
        #warn "\$t: $t";
        if ( $t <= 0 ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    #warn "\$ac: $ac";
    my $y1 = calc( $ac, $a, $b );
    my $y2 = calc( $wa, $a, $b );
    #warn "\$y1: $y1";
    #warn "\$y2: $y2";

    return $y1 <= $y2 ? $ac : $wa;
}

sub calc {
    my $n = shift;
    my $a = shift;
    my $b = shift;
    return $b * $n + $a / sqrt( $n + 1 );
}
