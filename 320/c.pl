#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $m = <> );
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. 3;

my @orders = (
    [ 0, 1, 2 ],
    [ 0, 2, 1 ],
    [ 1, 0, 2 ],
    [ 1, 2, 0 ],
    [ 2, 0, 1 ],
    [ 2, 1, 0 ],
);

my $min;

for my $order_ref ( @orders ) {
    for my $n ( 0 .. 9 ) {
        my $candidate = r( 0, $order_ref, $n );
        next
            unless defined $candidate;
        $min = min( $min // $candidate, $candidate );
    }
}

say $min // -1;

exit;

sub r {
    my( $t, $o_ref, $n ) = @_;

    if ( !@{ $o_ref } ) {
        return $t - 1;
    }

    my $order = shift @{ $o_ref };

    my $add;

    for ( my $i = 0; $i < $m; ++$i ) {
        if ( $s[ $order ][ ( $t + $i ) % $m ] == $n ) {
            $add = $i;
            last;
        }
    }

    my $result;

    if ( defined $add ) {
        $result = r( $t + $add + 1, $o_ref, $n );
    }

    unshift @{ $o_ref }, $order;

    return $result;
}
