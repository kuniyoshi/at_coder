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
$y += 0.5;

push @points, $points[0];

my $count;

for ( my $i = 0; $i < $#points; ++$i ) {
    my $from = $points[ $i ];
    my $to = $points[ $i + 1 ];

    if ( $to->[0] - $from->[0] == 0 ) {
        if ( $y >= min( $to->[1], $from->[1] ) && $y <= max( $to->[1], $from->[1] ) ) {
            $count++;
        }
        next;
    }

    my $a = ( $to->[1] - $from->[1] ) / ( $to->[0] - $from->[0] );

    if ( $a == 0 ) {
        next;
    }

    my $dy = $y - $from->[1];
    my $dx = $dy / $a;

    my $cx = $from->[0] + $dx;

    if ( $cx >= $from->[0] && $cx <= $to->[0] ) {
        $count++;
    }
}

say $count % 2 ? "INSIDE" : "OUTSIDE";

exit;

