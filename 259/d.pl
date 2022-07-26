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

for ( my $i = 0; $i < @circles; ++$i ) {
    for ( my $j = 0; $j < $i; ++$j ) {
        my $ri = $circles[ $i ][2];
        my $rj = $circles[ $j ][2];
        my $dx = $circles[ $i ][0] - $circles[ $j ][0];
        my $dy = $circles[ $i ][1] - $circles[ $j ][1];
        my $distance2 = $dx * $dx + $dy * $dy;

        next
            if $distance2 > ( ( $ri + $rj ) * ( $ri + $rj ) );

        next
            if ( ( ( $ri - $rj ) * ( $ri - $rj ) ) > $distance2 );

        push @{ $graph[ $i ] }, $j;
        push @{ $graph[ $j ] }, $i;
    }
}

my( $from, $to );

for ( my $i = 0; $i < @circles; ++$i ) {
    my( $x, $y, $r ) = @{ $circles[ $i ] };

    if ( !defined $from && ( ( ( $sx - $x ) * ( $sx - $x ) + ( $sy - $y ) * ( $sy - $y ) ) == $r * $r ) ) {
        $from = $i;
    }

    if ( !defined $to && ( ( ( $tx - $x ) * ( $tx - $x ) + ( $ty - $y ) * ( $ty - $y ) ) == $r * $r ) ) {
        $to = $i;
    }

    last
        if defined $from && defined $to;
}

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

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
