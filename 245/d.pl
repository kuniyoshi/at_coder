#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @c = do { chomp( my $l = <> ); split m{\s}, $l };

my @b;
my $remain = $m;

while ( $remain > 0 ) {
    LOOP_C_INDEX:
    for my $i ( reverse( 0 .. $n + $m ) ) { # c
        my $indexes_ref;
        my $acc = 0;

        my $max_j = $i < $n ? $i : $n;

        LOOP_A_INDEX:
        for my $j ( reverse( 0 .. $max_j ) ) { # a

            my $k = $i - $j;

            next
                if $k > $m;

            next
                if $a[ $j ] == 0 && !defined $b[ $k ];

            if ( !defined $b[ $k ] ) {
                $indexes_ref = [ $j, $k ];
                next;
            }

            if ( !defined $b[ $k ] ) {
                next LOOP_C_INDEX;
            }

            $acc = $acc + $a[ $j ] * $b[ $k ];
        }

        if ( !$indexes_ref ) {
            next LOOP_C_INDEX;
        }

        my( $a_index, $b_index ) = @{ $indexes_ref };
        $b[ $b_index ] = ( $c[ $i ] - $acc ) / $a[ $a_index ];
        $remain--;
    }
}

die "Could not complete b", Dumper \@b
    if $#b != $m || grep { !defined } @b;

say join q{ }, @b;

exit;
