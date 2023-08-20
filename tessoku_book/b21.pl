#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
chomp( my $s = <> );

say longest_palindrome( $s );

exit;


sub longest_palindrome {
    my $s = shift;
    my $n = length $s;
    my $t = reverse $s;

    my @dp = map { [ ( 0 ) x ( $n + 1 ) ] } 0 .. $n;

    for ( my $i = 0; $i < $n; ++$i ) {
        for ( my $j = 0; $j < $n; ++$j ) {
            if ( substr( $s, $i, 1) eq substr( $t, $j, 1) ) {
                $dp[ $i + 1 ][ $j + 1 ] = $dp[ $i ][ $j ] + 1;
            }
            else {
                $dp[ $i + 1 ][ $j + 1 ] = max( $dp[ $i + 1 ][ $j ], $dp[ $i ][ $j + 1 ] );
            }
        }
    }

    return $dp[ $n ][ $n ];
}

