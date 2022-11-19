#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $first = misjudge( $h * 60 + $m );
say $first;

exit;

sub misjudge {
    my $minutes = shift;

    for my $v ( $minutes .. $minutes + 24 * 60 ) {
        my $ih = int( $v / 60 );
        my $m = $v - $ih * 60;
        my $h = $ih % 24;

        next
            unless may_miss( $h, $m );

        return "$h $m";
    }
    die "Could not found misjudge time";
}

sub may_miss {
    my( $x, $y ) = @_;
    my $s = sprintf "%02d%02d", $x, $y;
    my( $a, $b, $c, $d ) = split m{}, $s;
    return ( is_valid( "$a$c", "$b$d" ) );
}

sub is_valid {
    my( $x, $y ) = @_;
    return $x >= 0 && $x < 24 && $y >= 0 && $y < 60;
}
