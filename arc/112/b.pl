#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $b, $c ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $min = f( -3e18 );
my $max = g( 3e18 );

say $max - $min + 1;

exit;

sub can {
    my $v = shift;
    my $distance = abs( $v - $b );
    my $is_sign_same = ( $v >= 0 && $b >= 0 ) || ( $v < 0 && $b < 0 );
}

sub f {
    my $wa = shift;
    my $ac = $b;

    while ( abs( $ac - $wa ) > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        ${ can( $wj ) ? \$ac : \$wa } = $wj;
    }

    return $ac;
}
