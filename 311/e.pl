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

my %is_hole;

for my $ab ( @ab ) {
    my( $i, $j ) = @{ $ab };
    $is_hole{ $i }{ $j }++;
}

my @acc = map { [ ( 0 ) x ( $w + 1 ) ] }
          1 .. $h + 1;

for my $i ( 1 .. $h ) {
    my $acc = 0;
    for my $j ( 1 .. $w ) {
        $acc += $acc[ $i ][ $j - 1 ] + ( $is_hole{ $i }{ $j } ? 0 : 1 );
        $acc[ $i ][ $j ] = $acc;
    }
}

for my $j ( 1 .. $w ) {
    my $acc = 0;
    for my $i ( 1 .. $h ) {
        $acc += $acc[ $i - 1 ][ $j ];
        $acc[ $i ][ $j ] += $acc;
    }
}

die map { join( qq{\t}, @{ $_ } ), "\n" } @acc;

exit;
