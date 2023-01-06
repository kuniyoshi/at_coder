#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $k = <> );

my %count = factors( $k );

my $n = bisect( \%count );

say $n;

exit;

sub f {
    my $n = shift;
    my $count_ref = shift;

    for my $key ( keys %{ $count_ref } ) {
        my $left = $n;
        my $count = 0;

        while ( $left > 1 ) {
            my $c = int( $left / $key );
            $count += $c;
            $left = $c;
        }

        return
            if $count < $count_ref->{ $key };
    }

    return 1;
}

sub bisect {
    my $count_ref = shift;

    my $wa = 2;
    my $ac = $k;

    while ( $ac - $wa > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( f( $wj, $count_ref ) ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    return $ac;
}

sub factors {
    my $k = shift;
    my $sqrt = sqrt $k;
    my %count;

    my $acc = $k;

    for ( my $i = 2; $i <= $sqrt; ++$i ) {
        while ( ( $acc % $i ) == 0 ) {
            $acc /= $i;
            $count{ $i }++;
        }
    }

    $count{ $acc }++
        if $acc > 1;

    return %count;
}
