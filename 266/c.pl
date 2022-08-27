#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @points = map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. 4;

say YesNo::get( is_convex( ) );

exit;

sub is_convex {
    for ( my $i = 0; $i < 4; ++$i ) {
        my $a = $points[ $i % @points ];
        my $b = $points[ ( $i + 1 ) % @points ];
        my $c = $points[ ( $i + 2 ) % @points ];
        my $d = $points[ ( $i + 3 ) % @points ];

        my $ac = v_sub( $c, $a );
        my $ab = v_sub( $b, $a );
        my $ad = v_sub( $d, $a );
        my $x = v_add( $ab, $ad );
        my $xa = v_sub( $a, $x );

        return
            if $
    }

    return 1;
}

sub l2 {
    my $v = shift;
    return $v->[0] ** 2 + $v->[1] ** 2;
}

sub v_add {
    my $u = shift;
    my $v = shift;
    return [ $u->[0] + $v->[0], $u->[1] + $v->[1] ];
}

sub dot {
    my $u = shift;
    my $v = shift;
    return $u->[0] * $v->[0] + $u->[1] * $v->[1];
}

sub v_sub {
    my $u = shift;
    my $v = shift;
    return [ $u->[0] - $v->[0], $u->[1] - $v->[1] ];
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
