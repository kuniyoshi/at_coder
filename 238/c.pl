#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use integer;

chomp( my $n = <> );

say recursive( $n );

exit;

sub recursive {
    my $x = shift;

    if ( length( $x ) == 1 ) {
        return( $x * ( 1 + $x ) / 2 );
    }

    my $base = 10 ** ( length( $x ) - 1 );

    my $a = 1;
    my $l = $x - $base + 1;
    my $n = $l - $a + 1;

    my $y = ( ( $n % 998244353 ) * ( $a + ( $l % 998244353 ) ) / 2 ) % 998244353;

    my $z = $base - 1;

    return( ( $y + ( recursive( $z ) % 998244353 ) ) % 998244353 );
}
