#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( first );

chomp( my $n = <> );
my( $sx, $sy, $tx, $ty ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @circles = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $n;

my @graph;

for my $i ( 0 .. $#circles ) {
    for my $j ( 0 .. $i - 1 ) {
        next
            if $j == $i;

        my $dx = $circles[ $i ][0] - $circles[ $j ][0];
        my $dy = $circles[ $i ][1] - $circles[ $j ][1];
        my $distance = sqrt( $dx * $dx + $dy * $dy );

        next
            if $distance > ( $circles[ $i ][2] + $circles[ $j ][2] );

        my $is_i_small = $circles[ $i ][2] < $circles[ $j ][2] ? 1 : 0;

        if ( $is_i_small ) {
            next
                if $circles[ $j ][2] > $distance + $circles[ $i ][2];
        }
        else {
            next
                if $circles[ $i ][2] > $distance + $circles[ $j ][2];
        }

        push @{ $graph[ $i ] }, $j;
        push @{ $graph[ $j ] }, $i;
    }
}

my $from = first { is_match( $circles[ $_ ], $sx, $sy ) } 0 .. $#circles;
my $to = first { is_match( $circles[ $_ ], $tx, $ty ) } 0 .. $#circles;

die "No **from** found"
    unless defined $from;
die "No **to** found"
    unless defined $to;

my @queue = ( $from );
my %visited;
my $found;

while ( @queue ) {
    my $v = shift @queue;

    next
        if $visited{ $v }++;

    if ( $v == $to ) {
        $found++;
        last;
    }

    push @queue, grep { !$visited{ $_ } } @{ $graph[ $v ] };
}

say YesNo::get( $found );

exit;

sub is_match {
    my $ref = shift;
    my $sx = shift;
    my $sy = shift;
    my $x = $ref->[0];
    my $y = $ref->[1];
    my $r = $ref->[2];

    return ( ( $x + $r ) == $sx && $y == $sy )
        || ( ( $x - $r ) == $sx && $y == $sy )
        || ( $x == $sx && ( $y + $r ) == $sy )
        || ( $x == $sx && ( $y - $r ) == $sy );
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
