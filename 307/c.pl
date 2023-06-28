#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $ha, $wa, @a ) = read_matrix( );
my( $hb, $wb, @b ) = read_matrix( );
my( $hx, $wx, @x ) = read_matrix( );

for ( my $ai = 0; $ai < $hx; ++$ai ) {
    last
        if $ai + $ha > $hx;
    for ( my $aj = 0; $aj < $wx; ++$aj ) {
        last
            if $aj + $wa > $wx;
        for ( my $bi = 0; $bi < $hx; ++$bi ) {
            last
                if $bi + $hb > $hx;
            for ( my $bj = 0; $bj < $wx; ++$bj ) {
                last
                    if $bj + $wb > $wx;

                my $can = 1;
                for ( my $d = 0; $d < $hx; ++$d ) {
                    my $x = shift_v( \@a, $ai + $d, $wx - $aj - $wa ) | shift_v( \@b, $bi + $d, $wx - $bj - $wb );
                    warn shift_v(  \@a, $ai + $d, $wx - $aj - $wa );
                    warn shift_v( \@b, $bi + $d, $wx - $bj - $wb );
                    warn "($ai, $aj, $bi, $bj)";
                    warn "\$x: $x, $x[ $d ]";
                    undef $can
                        if $x != $x[ $d ];
                }
                if ( $can ) {
                    say YesNo::get( 1 );
                    exit;
                }
            }
        }
    }
}

say YesNo::get( 0 );

exit;

sub shift_v {
    my $ref = shift;
    my $i = shift;
    my $shift = shift;
    return 0
        if $i > $#{ $ref };
    return $ref->[ $i ] << $shift;
}

sub read_matrix {
    my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
    my @values = map { chomp; my @l = split m{}; to_number( @l ) }
               map { scalar <> }
               1 .. $h;

    while ( !grep { $_ & 1 } @values ) {
        $w--;
        $_ >>= 1
            for @values;
    }

    while ( !$values[0] ) {
        shift @values;
        $h--;
    }

    while ( !$values[-1] ) {
        pop @values;
        $h--;
    }

    return $h, $w, @values;
}

sub to_number {
    my @bits = reverse map { $_ eq q{#} ? 1 : 0 } @_;
    my $value = 0;
    for ( my $i = 0; $i < @bits; ++$i ) {
        $value += $bits[ $i ] << $i;
    }
    return $value;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
