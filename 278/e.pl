#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $height, $width, $n, $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $height;

my %count;
$count{ $_ }++
        for map { @{ $_ } } @a;

my @deltas = map { my $w = $_; [ map { [ $_, $w ] } 0 .. $h - 1 ] } 0 .. $w - 1;

for my $i ( 1 .. $#deltas ) {
    my $r1 = $deltas[ $i ];
    for my $r2 ( @{ $r1 } ) {
        my $value = $a[ $r2->[0] ][ $r2->[1] ];
        $count{ $value }--;
        delete $count{ $value };
    }
}

for my $i ( 0 .. $height - $h ) {
    for my $j ( 0 .. $width - $w ) {
        my $ref = shift @deltas;
        for my $r ( @{ $ref } ) {
            my $value = $a[ $r->[0] ][ $r->[1] ];
            $count{ $value }--;
            delete $count{ $value };
        }
        printf "%d ", scalar %count;
        push @deltas, $ref;
    }
    say q{};
}

exit;
