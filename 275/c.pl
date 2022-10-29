#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( all );

my @cells = map { chomp; [ split m{} ] }
            map { scalar <> }
            1 .. 9;

my @points = map {
    my $r = $_;
    grep { $cells[ $_->[0] ][ $_->[1] ] eq q{#} } map { [ $r, $_ ] } 0 .. 8;
} 0 .. 8;

my %distance;

for my $i ( 0 .. $#points ) {
    for my $j ( 0 .. $#points ) {
        $distance{ $i }{ $j } = pow( $points[ $i ][0] - $points[ $j ][0] ) + pow( $points[ $i ][1] - $points[ $j ][1] );
    }
}

for my $k ( 0 .. $#points ) {
    for my $i ( 0 .. $#points ) {
        for my $j ( 0 .. $#points ) {
            if ( $distance{ $i }{ $j } > $distance{ $i }{ $k } + $distance{ $k }{ $j } ) {
                $distance{ $i }{ $j } = $distance{ $i }{ $k } + $distance{ $k }{ $j };
            }
        }
    }
}

my $count = 0;

for my $u ( 0 .. $#points ) {
    for my $v ( 0 .. $#points ) {
        for my $w ( 0 .. $#points ) {
            for my $x ( 0 .. $#points ) {
                next
                    if $u == $v || $u == $w || $u == $x || $v == $w || $v == $x || $w == $x;
                next
                    if !is_angle( @points[ $u, $v, $w ] ) || !is_angle( @points[ $v, $w, $x ] ) || !is_angle( @points[ $w, $x, $u ] ) || !is_angle( @points[ $x, $u, $v ] );
                my @distances = (
                    $distance{ $u }{ $v },
                    $distance{ $v }{ $w },
                    $distance{ $w }{ $x },
                    $distance{ $x }{ $u },
                );
                if ( all { $_ == $distances[0] } @distances ) {
                    #warn "($u, $v, $w, $x)";
                    #warn "d: ", join q{, }, @distances;
                    $count++;
                }
            }
        }
    }
}

say $count / 4;

exit;

sub is_angle {
    my $a = shift;
    my $b = shift;
    my $c = shift;
    my $ba = [ $a->[0] - $b->[0], $a->[1] - $b->[1] ];
    my $bc = [ $c->[0] - $b->[0], $c->[1] - $b->[1] ];
    my $cross = $ba->[0] * $bc->[1] - $ba->[1] * $bc->[0];
    return $cross > 0;
}

sub pow {
    my $value = shift;
    return $value * $value;
}
