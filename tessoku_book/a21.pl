#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );
use Memoize;

memoize( "dfs" );

chomp( my $n = <> );
my @conditions = map { chomp; [ split m{\s} ] }
                 map { scalar <> }
                 1 .. $n;
$_->[0]--
    for @conditions;

say dfs( 0, $n - 1, 0 );

exit;

sub dfs {
    my( $left, $right, $score ) = @_;

    if ( $left > $right ) {
        return $score;
    }

    my $add_when_left = do {
        my $p = $conditions[ $left ][0];
        ( $p >= $left && $p <= $right ) ? $conditions[ $left ][1] : 0;
    };
    my $add_when_right = do {
        my $p = $conditions[ $right ][0];
        ( $p >= $left && $p <= $right ) ? $conditions[ $right ][1] : 0;
    };

    return max( dfs( $left + 1, $right, $score + $add_when_left ), dfs( $left, $right - 1, $score + $add_when_right ) );
}
