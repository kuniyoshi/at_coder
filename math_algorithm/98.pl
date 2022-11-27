#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

chomp( my $n = <> );
my @points = map { chomp( my $l = <> ); [ split m{\s}, $l ] }
             1 .. $n;
my( $x, $y ) = do { chomp( my $l = <> ); split m{\s}, $l };
#$y += 1e-9;

push @points, $points[0];

my $count = 0;

for ( my $i = 0; $i < $#points; ++$i ) {
    my $from = $points[ $i ];
    my $to = $points[ $i + 1 ];

    if ( $from->[1] > $to->[1] ) {
        ( $from, $to ) = ( $to, $from );
    }

    if ( $y >= $to->[1] || $y < $from->[1] ) {
        next;
    }

    my $a = [ $from->[0] - $x, $from->[1] - $y ];
    my $b = [ $to->[0] - $x, $to->[1] - $y ];

    my $ea = $a->[0] * $b->[1] - $a->[1] * $b->[0];

    if ( $ea < 0 ) {
        $count++;
    }
}

say $count % 2 ? "INSIDE" : "OUTSIDE";

exit;

