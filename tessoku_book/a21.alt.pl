#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @conditions = map { chomp; [ split m{\s} ] }
                 map { scalar <> }
                 1 .. $n;

my %cache;

$_->[0]--
    for @conditions;

say dfs( 0, $n - 1, 0 );

exit;

sub dfs {
    my( $left, $right, $score ) = @_;

    return $cache{ $left }{ $right }
        if $cache{ $left }{ $right };

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

    $cache{ $left + 1 }{ $right } = dfs( $left + 1, $right, $score + $add_when_left );
    $cache{ $left }{ $right + 1 } = dfs( $left, $right - 1, $score + $add_when_right );

    return max( $cache{ $left + 1 }{ $right }, $cache{ $left }{ $right + 1 } );
}
