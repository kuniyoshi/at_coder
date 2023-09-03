#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp;
my @mins = ( 0 );

for my $a ( @a ) {
    $dp[ $a ] //= 1;

    my $ac = 0;
    my $wa = $a;

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( defined $mins[ $wj ] && $mins[ $wj ] < $a ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    die "Could not find mins for $a"
        unless defined $mins[ $ac ];

    $dp[ $a ] = max( $ac + 1, $dp[ $a ] );

    $mins[ $dp[ $a ] ] = $a;

    #    for ( my $i = 0; $i < $n; ++$i ) {
    #        if ( $dp[ $a[ $i ] ] && $a[ $i ] < $a ) {
    #            $dp[ $a ] = max( $dp[ $a ], $dp[ $a[ $i ] ] + 1 );
    #        }
    #    }
    #
    #    $mins[ $dp[ $a ] ] = min( $mins[ $dp[ $a ] ] // $dp[ $a ], $dp[ $a ] );
}

say max( grep { defined } @dp );

exit;
