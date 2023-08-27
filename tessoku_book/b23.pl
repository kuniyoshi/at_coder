#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );
use Memoize qw( memoize );

memoize( "dfs" );

chomp( my $n = <> );
my @xy = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $n;

my %distance;

for ( my $i = 0; $i < $n; ++$i ) {
    for ( my $j = 0; $j < $n; ++$j ) {
        $distance{ $i }{ $j } = sqrt( ( $xy[ $j ][0] - $xy[ $i ][0] ) ** 2 + ( $xy[ $j ][1] - $xy[ $i ][1] ) ** 2 );
    }
}

my $squared = min( grep { defined } map { dfs( 0, $_, $_, 0 ) } 0 .. $n - 1 )
    or die "No route found";

say $squared;

exit;

sub dfs {
    my $passed = shift;
    my $current = shift;
    my $first = shift;
    my $total = shift;

    #    warn sprintf "(%0${n}b, %d, %d)", $passed, $current, $total;

    return $total
        if ( ( $passed == ( 1 << $n ) - 1 ) && $current == $first );

    return
        if $passed & ( 1 << $current );

    my $min;

    $passed |= 1 << $current;

    for ( my $i = 0; $i < $n; ++$i ) {
        next
            if $passed & 1 << $i && $i != $first;
        my $addition = $distance{ $current }{ $i };
        my $candidate = dfs( $passed, $i, $first, $total + $addition )
            or next;
        $min //= $candidate;
        $min = min( $min, $candidate );
    }

    return $min;
}

__END__

for ( my $i = 0; $i < $n; ++$i ) {
    $dp[0][ $i ] = 0;
}

for ( my $i = 1; $i < 1 << $n; ++$i ) {
    for ( my $j = 0; $j < $n; ++$j ) {
        $dp[ $i ][ $j ] = $dp[ $i - 1 ][
    }
}

for ( my $i = 0; $i < $n; ++$i ) {
    $dp[ 1 << $i ] = 0;

    for ( my $j = 0; $j < 1 << $n; ++$j ) {
        next
            if !defined $dp[ $j ];

        if ( !defined $dp[ $j | ( 1 << $i ) ] ) {
            $dp[ $j | ( 1 << $i ) ] = $dp[ $j ] + min_distance( $j, $i );
        }
        else {
            $dp[ $j | ( 1 << $i ) ] = min( $dp[ $j | ( 1 << $i ) ], $dp[ $j ] + min_distance( $j, $i ) );
        }
    }
}

die Dumper \@dp;


exit;


