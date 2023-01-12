#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MOD = 998244353;

my( $n, $p ) = do { chomp( my $l = <> ); split m{\s}, $l };

say f( 0, $n );

exit;

sub f {
    my $count = shift;
    my $remain = shift;

    if ( $remain == 0 ) {
        return 0;
    }

    if ( $remain == 1 ) {
        return 1;
    }

    my $total = ( 100 - $p ) / 100 * f( $count + 1, $remain - 1 ) + $p / 100 * f( $count + 1, $remain - 2 );

    return $total;
}
