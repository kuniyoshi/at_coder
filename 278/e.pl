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

for my $i ( 0 .. $height - $h ) {
    for my $r ( map { @{ $_ } } @deltas ) {
        my $value = $a[ $i + $r->[0] ][ $r->[1] ];
        $count{ $value }--;
        delete $count{ $value }
            unless $count{ $value };
    }

    for my $j ( 0 .. $width - $w ) {
        printf "%d ", scalar %count;
        for my $r ( @{ $deltas[0] } ) {
            my $value = $a[ $i + $r->[0] ][ $j + $r->[1] ];
            $count{ $value }++;
        }
        for my $r ( @{ $deltas[-1] } ) {
            my $value = $a[ $i + $r->[0] ][ $j + $r->[1] ];
            $count{ $value }--;
            delete $count{ $value }
                unless $count{ $value };
        }
    }

    say q{};

    for my $r ( map { @{ $_ } } @deltas ) {
        my $value = $a[ $i + $r->[0] ][ $width - $w + $r->[1] ];
        $count{ $value }++;
    }
}

exit;
