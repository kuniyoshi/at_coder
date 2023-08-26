#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $n = <> );
my @xy = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $n;

my %distance;

for ( my $i = 0; $i < $n; ++$i ) {
    for ( my $j = 0; $j < $n; ++$j ) {
        $distance{ $i }{ $j } = ( $xy[ $j ][0] - $xy[ $i ][0] ) ** 2 + ( $xy[ $j ][1] - $xy[ $i ][1] ) ** 2;
    }
}

my @dp;

dfs( 0, $_ )
    for 0 .. $n - 1;

say min( map { $dp[ ( 1 << $n ) - 1 ][ $_ ] } 0 .. $n - 1 );

exit;

sub dfs {
    my $visited = shift;
    my $current = shift;
    return
        if $visited == ( 1 << $n ) - 1;
    die "$current has visited already"
        if $visited & ( 1 << $current );

    $visited |= 1 << $current;

    for ( my $i = 0; $i < $n; ++$i ) {
        next
            if $visited & ( 1 << $i );
        my $addition = $distance{ $current }{ $i };
        $dp[ 
        dfs( $visited, $i );
    }
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


