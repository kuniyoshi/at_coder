#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $n = tri( $a, $b );
#warn "\$n: $n";

say f( $n, $a, $b );

exit;

sub tri {
    my $l = 0;
    my $r = 1e18 + 1;

    while ( $r - $l > 2 ) {
        #warn "[$l, $r]";
        my $t1 = int( ( 2 * $l + $r ) / 3 );
        my $t2 = int( ( 2 * $r + $l ) / 3 );

        if ( f( $t1, $a, $b ) > f( $t2, $a, $b ) ) {
            $l = $t1;
        }
        elsif ( f( $t1, $a, $b ) < f( $t2, $a, $b ) ) {
            $r = $t2;
        }
        else {
            $r = $t2;
        }
    }

    #warn "[$l, $r]";
    #return f( $l, $a, $b ) < f( $r, $a, $b ) ? $l : $r;
    return f( $l + 1, $a, $b ) < f( $l, $a, $b ) ? $l + 1 : $l;
}

sub f {
    my $n = shift;
    my $a = shift;
    my $b = shift;
    return $b * $n + $a / sqrt( $n + 1 );
}
