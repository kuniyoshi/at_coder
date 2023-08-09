#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @ab = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $n;

my @acc = map { [ ( 0 ) x ( $w + 1 ) ] }
          1 .. $h + 1;

for my $ab ( @ab ) {
    my( $i, $j ) = @{ $ab };
    $acc[ $i ][ $j ] = 1;
}


for my $i ( 1 .. $h ) {
    for my $j ( 1 .. $w ) {
        $acc[ $i ][ $j ] += $acc[ $i ][ $j - 1 ];
    }
}

for my $j ( 1 .. $w ) {
    for my $i ( 1 .. $h ) {
        $acc[ $i ][ $j ] += $acc[ $i - 1 ][ $j ];
    }
}

die map { join( qq{\t}, @{ $_ } ), "\n" } @acc;

exit;
