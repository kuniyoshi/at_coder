#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. ( 2 * $n - 1 );

my $max = 0;
dfs( [ ( 0 ) x ( 2 * $n ) ], 0, \$max );
say $max;

exit;

sub dfs {
    my $indexes_ref = shift;
    my $acc = shift;
    my $max_ref = shift;

    my $first = -1;

    for ( my $i = 0; $i < @{ $indexes_ref }; ++$i ) {
        next
            if $indexes_ref->[ $i ];
        $first = $i;
        last;
    }

    if ( $first == -1 ) {
        ${ $max_ref } = $acc
            if $acc > ${ $max_ref };
        return;
    }

    $indexes_ref->[ $first ] = 1;

    for ( my $i = 0; $i < @{ $indexes_ref }; ++$i ) {
        next
            if $indexes_ref->[ $i ];
        $indexes_ref->[ $i ] = 1;
        dfs( $indexes_ref, $acc ^ $a[ $first ][ $i - $first - 1 ], $max_ref );
        $indexes_ref->[ $i ] = 0;
    }

    $indexes_ref->[ $first ] = 0;
}
