#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use POSIX ( );

chomp( my $n = <> );

if ( $n == 0 ) {
    say $n;
    exit;
}

my @ac = ( 1e6, 1e6 );
my @wa = ( -1, -1 );

my @diff = ( $ac[0] - $wa[0], $ac[1] - $wa[1] );

#while ( $ac[0] - $wa[0] + $ac[1] - $wa[1] > 1 ) {
my $d = 8;
while ( 1 ) {
    warn "($wa[0], $wa[1]), ($ac[0], $ac[1])";
    my $l0 = $wa[0];
    my $r0 = $ac[0];

    while ( ( my $wj = POSIX::floor( ( $r0 + $l0 ) / 2 ) ) > $l0 ) {
        warn "($l0, $wj, $r0)";
        if ( f( $wj, $ac[1] ) >= $n ) {
            $r0 = $wj;
        }
        else {
            $l0 = $wj;
        }
    }

    my $l1 = $wa[1];
    my $r1 = $ac[1];

    while ( ( my $wj = POSIX::floor( ( $r1 + $l1 ) / 2 ) ) > $l1 ) {
        warn "($l1, $wj, $r1)";
        if ( f( $r0, $wj ) >= $n ) {
            $r1 = $wj;
        }
        else {
            $l1 = $wj;
        }
    }

    $ac[0] = $r0;
    $ac[1] = $r1;
    $wa[0] = $l0;
    $wa[1] = $l1;

    my @new = ( $ac[0] - $wa[0], $ac[1] - $wa[1] );

    if ( $new[0] == $diff[0] && $new[1] == $diff[1] ) {
        $d--;
        last
            unless $d;
    }

    $diff[0] = $new[0];
    $diff[1] = $new[1];
}

say f( $ac[0], $ac[1] );

exit;

sub f {
    my( $a, $b ) = @_;
    my $x = $a ** 3 + $a ** 2 * $b + $a * $b ** 2 + $b ** 3;
    return $x;
}
