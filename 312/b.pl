#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

my @deltas = (
    [ 0, 3 ],
    [ 1, 3 ],
    [ 2, 3 ],
    [ 3, 3 ],
    [ 3, 2 ],
    [ 3, 1 ],
    [ 3, 0 ],
    [ 5, 5 ],
    [ 5, 6 ],
    [ 5, 7 ],
    [ 5, 8 ],
    [ 6, 5 ],
    [ 7, 5 ],
    [ 8, 5 ],
);

for ( my $i = 0; $i < $n; ++$i ) {
    for ( my $j = 0; $j < $m; ++$j ) {
        next
            unless t( $i, $j );
        printf "%d %d\n", $i + 1, $j + 1;
    }
}

exit;

sub is_in {
    my( $i, $j ) = @_;
    return $i >= 0 && $i < $n && $j >= 0 && $j < $m;
}

sub t {
    my( $y, $x ) = @_;
    return
        unless is_in( $y, $x );
    return
        unless is_in( $y + 8, $x + 8 );

    my %count = (
        q{#} => 0,
        q{?} => 0,
        q{.} => 0,
    );

    for my $i ( 0 .. 2 ) {
        for my $j ( 0 .. 2 ) {
            $count{ $s[ $y + $i ][ $x + $j ] }++;
        }
    }

    for my $i ( 6 .. 8 ) {
        for my $j ( 6 .. 8 ) {
            $count{ $s[ $y + $i ][ $x + $j ] }++;
        }
    }

    my $pass = $count{q{#}} == 18 || ( $count{q{#}} < 18 && $count{q{#}} + $count{q{?}} >= 18 );

    return
        if !$pass;

    return !grep { $s[ $y + $_->[0] ][ $x + $_->[1] ] eq q{#} } @deltas;
}

