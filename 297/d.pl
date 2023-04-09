#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @pair = ( $a, $b );

my $count = 0;

while ( $pair[0] != $pair[1] ) {
    my $large = $pair[0] > $pair[1] ? 0 : 1;
    my $small = !$large || 0;

    my $ac = 1;
    my $wa = int( $pair[ $large ] / $pair[ $small ] ) + 1;

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $pair[ $large ] - $wj * $pair[ $small ] >= $pair[ $small ] ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    $count += $ac;

    $pair[ $large ] = $pair[ $large ] - $ac * $pair[ $small ];
}

say $count;

exit;
