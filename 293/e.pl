#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $x = 4;
my $m = 700;

say pow( 3, 0 );
say pow( 3, 1 );
say pow( 3, 2 );
say pow( 3, 3 );

exit;

#my( $a, $x, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $total = 0;

for my $i ( 0 .. $x - 1 ) {
    $total = ( $total + pow( $a, $i ) ) % $m;
}

say $total;

exit;

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
