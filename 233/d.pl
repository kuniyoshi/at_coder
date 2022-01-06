#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $acc = 0;
my @acc = ( 0 );

for my $a ( @a ) {
    $acc = $acc + $a;
    push @acc, $acc;
}

my $total = 0;

for ( my $r = 0; $r < @a; ++$r ) {
    for ( my $l = 0; $l <= $r; ++$l ) {
        my $sum = $acc[ $r + 1 ] - $acc[ $l ];
        $total = $total + ( $sum == $k );
    }
}

say $total;

exit;
