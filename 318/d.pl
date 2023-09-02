#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @costs = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n - 1;

my %cost;

for ( my $i = 0; $i < @costs; ++$i ) {
    for ( my $j = 0; $j < @{ $costs[ $i ] }; ++$j ) {
        $cost{ $i }{ $j + $i + 1 } = $costs[ $i ][ $j ];
        $cost{ $j + $i + 1 }{ $i } = $costs[ $i ][ $j ];
    }
}

my @dp = ( 0 );

for ( my $i = 0; $i < 2 ** $n; ++$i ) {
    next
        unless defined $dp[ $i ];

    for ( my $j = 0; $j < $n; ++$j ) {
        for ( my $k = 0; $k < $n; ++$k ) {
            next
                if $k == $j;
            next
                if ( ( $i & 1 << $j ) || ( $i & 1 << $k ) );
            my $next = $i | ( 1 << $j ) | ( 1 << $k );
            if ( !defined $dp[ $next ] ) {
                $dp[ $next ] = $dp[ $i ] + $cost{ $j }{ $k };
            }
            else {
                $dp[ $next ] = max( $dp[ $next ], $dp[ $i ] + $cost{ $j }{ $k } );
            }
        }
    }
}

say max( grep { defined } @dp );

exit;
