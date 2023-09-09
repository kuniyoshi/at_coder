#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max min );

chomp( my $n = <> );
my @y = map { $_->[1] }
        sort { $a->[0] <=> $b->[0] }
        sort { $b->[1] <=> $a->[1] }
        map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $n;

my @dp;
my @mins = ( 0 );

for my $y ( @y ) {
    $dp[ $y ] = bin( $y ) + 1;
    $mins[ $dp[ $y ] ] = min(
        $mins[ $dp[ $y ] ] // $y,
        $y,
    );
}

say max( grep { defined } @dp );

exit;

sub bin {
    my $value = shift;

    my $ac = 0;
    my $wa = $n + 1;

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( !defined $mins[ $wj ] ) {
            $wa = $wj;
            next;
        }

        if ( $mins[ $wj ] < $value ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    return $ac;
}
