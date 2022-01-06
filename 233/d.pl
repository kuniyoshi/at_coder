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
my %count;

for ( my $r = 0; $r < @a; ++$r ) {
    my $l = $r;

    $count{ $k + $acc[ $l ] }++;

    $total = $total + ( $count{ $acc[ $r + 1 ] } // 0 );
}

say $total;

exit;
