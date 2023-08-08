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

my @dp = map { [ ( 0 ) x ( $n + 2 ) ] } 0 .. $n + 1;

for ( my $i = 1; $i <= $n; ++$i ) {
    for ( my $j = $n; $j >= 1; --$j ) {
        next
            if $j < $i;
        my $a = score_l( $i - 1, $j );
        my $b = score_r( $i, $j + 1 );
        $dp[ $i ][ $j ] = max( $dp[ $i - 1 ][ $j ] + $a, $dp[ $i ][ $j + 1 ] + $b );
    }
}

say max( map { @{ $_ } } @dp );

exit;

sub score_l {
    my $left = shift;
    my $right = shift;
    return 0
        if $left < 1;
    return score_( $left, $right, $conditions[ $left - 1 ] );
}

sub score_r {
    my $left = shift;
    my $right = shift;
    return 0
        if $right > $n;
    return score_( $left, $right, $conditions[ $right - 1 ] );
}

sub score_ {
    my $left = shift;
    my $right = shift;
    my( $p, $a ) = @{ shift( ) };
    return $p >= $left && $p <= $right ? $a : 0;
}

__END__
1 2 3 4

