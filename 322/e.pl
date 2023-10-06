#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );
use Memoize;

memoize( "dfs" );

my( $n, $k, $p ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @plans = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

say dfs( 0, 0, 0 ) // -1;

exit;

sub dfs {
    my $next_plan = shift;
    my $features = shift;
    my $cost = shift;

    return $cost
        if is_fulfill( $features );

    if ( $next_plan == $n ) {
        return;
    }

    my $did = dfs( $next_plan + 1, add( $features, $plans[ $next_plan ] ), $cost + $plans[ $next_plan ][0] );
    my $not = dfs( $next_plan + 1, $features, $cost );

    if ( defined $did && defined $not ) {
        return min( $did, $not );
    }
    elsif ( defined $did ) {
        return $did;
    }
    elsif ( defined $not ) {
        return $not;
    }
    else {
        return;
    }
}

sub is_fulfill {
    my $features = shift;

    for ( my $i = 0; $i < $k; ++$i ) {
        my $f = ( $features & ( 7 << ( $i * 3 ) ) ) >> ( $i * 3 );
        return
            unless $f >= $p;
    }

    return 1;
}

sub add {
    my $features = shift;
    my $ref = shift;

    for ( my $i = 0; $i < $k; ++$i ) {
        my $f = $ref->[ $i + 1 ];
        my $current = ( $features & ( 7 << ( $i * 3 ) ) ) >> ( $i * 3 );
        my $new = min( $current + $f, $p );
        $features &= ( 2 ** ( $k * 3 ) - 1 ) ^ ( 7 << ( $i * 3 ) );
        $features |= $new << ( $i * 3 );
    }

    return $features;
}
