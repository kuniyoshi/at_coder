#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $x, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $total = 0;

for my $i ( 0 .. $x - 1 ) {
    $total = ( $total + f( $a, $i ) ) % $m;
}

say $total;

exit;

sub f {
    my $x = shift;
    my $y = shift;
    my $a = 1;

    while ( $y ) {
        if ( $y & 1 ) {
            $a *= $x;
        }
        $x *= $x;
        $y >>= 1;
    }

    return $a;
}

sub pow {
    my( $a, $b ) = @_;
    return 1
        unless $b;
    return $a
        if $b == 1;
    my $c = pow( $a, int( $b / 2 ) );
    if ( $b % 2 ) {
        return( ( $c * $c ) % $m );
    }
    else {
        warn "\$c: $c";
        warn "x: ", int( $b / 2 ) - 1;
        return( ( $c * pow( $a, int( $b / 2 ) - 1 ) ) % $m );
    }
}
