#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @jumps = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

my $wa = 0;
my $ac = 5e9;

while ( $ac - $wa > 1 ) {
    my $wj = int( ( $wa + $ac ) / 2 );

    if ( can( $wj ) ) {
        $ac = $wj;
    }
    else {
        $wa = $wj;
    }
}

say $ac;

exit;

sub can {
    my $s = shift;

    my @connected;

    for my $from ( 0 .. $n - 1 ) {
        for my $to ( 0 .. $n - 1 ) {
            my $distance = abs( $jumps[ $from ][0] - $jumps[ $to ][0] )
                + abs( $jumps[ $from ][1] - $jumps[ $to ][1] );

            $connected[ $from ][ $to ] = $distance <= $s * $jumps[ $from ][2];
        }
    }

    for my $i ( 0 .. $n - 1 ) {
        my %visited;
        my @queue = ( $i );

        while ( @queue ) {
            my $current = shift @queue;
            next
                if $visited{ $current }++;
            push @queue, grep { !$visited{ $_ } && $connected[ $current ][ $_ ] } ( 0 .. $n - 1 );
        }

        return 1
            if %visited == $n;
    }

    return;
}
