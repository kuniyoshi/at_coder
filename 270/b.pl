#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $x, $y, $z ) = do { chomp( my $l = <> ); split m{\s}, $l };

if ( can_not_be( ) ) {
    say -1;
    exit;
}

if ( can_straight( ) || can_pass( ) ) {
    say abs $x;
    exit;
}

say 2 * abs( $z ) + abs( $x );

exit;

sub can_pass {
    my $is_hammer_close = ( $z > 0 && $y > 0 && $z < $y )
        || ( $z < 0 && $y < 0 && $z > $y );
    return $is_hammer_close;
}

sub can_straight {
    my $far = abs( $y ) > abs( $x );
    my $opposit = ( $x > 0 && $y < 0 )
        || ( $x < 0 && $y > 0 );
    return $far || $opposit;
}

sub can_not_be {
    my $is_same = ( $x > 0 && $y > 0 && $z > 0 )
        || ( $x < 0 && $y < 0 && $z < 0 );
    return
        unless $is_same;
    if ( $x > 0 ) {
        return $y < $x && $y < $z;
    }
    else {
        return $y > $x && $y > $z;
    }
}
