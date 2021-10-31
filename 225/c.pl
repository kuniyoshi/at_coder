#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $h = <> ); split m{\s}, $h };
my @b = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $n;

my( $min_i, $min_j ) = get_left_top( $b[0][0] );

my $max_j = min( 7, $min_j + $m - 1 );

my $is = is_yes( );
say $is ? "Yes" : "No";

exit;

sub is_yes {
    for my $i ( $min_i .. $min_i + $n - 1 ) {
        for my $j ( $min_j .. $max_j ) {
            my $index_i = $i - $min_i;
            my $index_j = $j - $min_j;
            my $b = $b[ $index_i ][ $index_j ];
            my $expected = ( $i - 1 ) * 7 + $j;

            return
                if $b != $expected;
        }
    }

    return 1;
}

sub min {
    my( $a, $b ) = @_;
    return $a > $b ? $b : $a;
}

sub get_left_top {
    my $b = shift;
    my $j = $b % 7;

    $j = 7
        if $j == 0;

    my $i = int( $b / 7 ) + ( $j != 7 );

    return ( $i, $j );
}
