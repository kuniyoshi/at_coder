#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $h, $w, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @ab = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $n;

my %is_hole;
$is_hole{ $_->[0] }{ $_->[1] }++
    for @ab;

my @acc = map { [ ( 0 ) x ( $w + 1 ) ] }
          1 .. $h + 1;

for my $ab ( @ab ) {
    my( $i, $j ) = @{ $ab };
    $acc[ $i ][ $j ] = 1;
}


for my $i ( 1 .. $h ) {
    for my $j ( 1 .. $w ) {
        $acc[ $i ][ $j ] += $acc[ $i ][ $j - 1 ];
    }
}

for my $j ( 1 .. $w ) {
    for my $i ( 1 .. $h ) {
        $acc[ $i ][ $j ] += $acc[ $i - 1 ][ $j ];
    }
}

#warn map { join( qq{\t}, @{ $_ } ), "\n" } @acc;

my $max_length = min( $h, $w );

my $count = 0;

for my $i ( 1 .. $h ) {
    for my $j ( 1 .. $w ) {
        next
            if $is_hole{ $i }{ $j };
        my $wa = $max_length;
        my $ac = 0;

        while ( $wa - $ac > 1 ) {
            my $wj = int( ( $wa + $ac ) / 2 );
            my $can_be = $wj + $i <= $h && $wj + $j <= $w;

            if ( !$can_be ) {
                $wa = $wj;
                next;
            }

            my $holes = $acc[ $i + $wj ][ $j + $wj ]
                + $acc[ $i ][ $j ]
                - $acc[ $i - 1 ][ $j + $wj ]
                - $acc[ $i + $wj ][ $j - 1 ];

            if ( !$holes ) {
                $ac = $wj;
            }
            else {
                $wa = $wj;
            }
        }

        #        warn "( $i, $j ) -> ", $ac + 1;

        $count += $ac + 1;
    }
}

say $count;

exit;
