#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

if ( $a > 1e18 / $b ) {
    say -1;
    exit;
}

my $gcd = gcd( $a, $b );
my $lcm = $a * $b / $gcd;

say $lcm;


exit;

sub gcd {
    my( $a, $b ) = @_;
    return $a > $b ? gcd_impl( $a, $b ) : gcd_impl( $b, $a );
}

sub gcd_impl {
    my( $large, $small ) = @_;
    my $new = $large % $small;
    return $small
        if $new == 0;
    gcd_impl( $small, $new );
}
