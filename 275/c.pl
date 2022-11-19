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

my %existence;
$existence{ $_->[0] }{ $_->[1] }++
    for @points;

my $count = 0;

for my $i ( 0 .. $#points ) {
    for my $j ( 0 .. $#points ) {
        next
            if $j == $i;

        $count++
            if is_square( $i, $j );
    }
}

say $count / 4;

exit;

sub is_square {
    my( $p1, $p2 ) = @_;
    my @a = @{ $points[ $p1 ] };
    my @b = @{ $points[ $p2 ] };
    my $di = $b[0] - $a[0];
    my $dj = $b[1] - $a[1];
    my @c = ( $b[0] - $dj, $b[1] + $di );
    my @d = ( $c[0] - $di, $c[1] - $dj );
    return $existence{ $c[0] }{ $c[1] }
        && $existence{ $d[0] }{ $d[1] };
}
