#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

my( $x, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $current = $x;

for my $i ( 0 .. $k - 1 ) {
    #warn "f($current, $i) = ", get_y( $current, $i );
    my $y = get_y( $current, $i );
    $current = $y;
}

say $current;

exit;

sub get_y {
    my $value = shift;
    my $sholder = shift;
    my $base = 10 ** ( $sholder + 1 );
    my $mod = $value % $base;
    my @digits = reverse split m{}, $mod;
    my $add = ( $digits[ $sholder ] // 0 ) >= 5 ? $base : 0;
    return $value - $mod + $add;
}
