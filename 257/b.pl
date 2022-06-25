#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k, $q ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @l = do { chomp( my $l = <> ); split m{\s}, $l };

my @cells = ( 0 ) x $n;

for my $a ( @a ) {
    $cells[ $a - 1 ]++;
}

my @positions = @a;
$_--
    for @positions;

for my $l ( @l ) {
    die "not here: $l"
        unless $cells[ $positions[ $l - 1 ] ];
    next
        if $positions[ $l - 1 ] == $n - 1;
    die "out of cell"
        unless defined $cells[ $positions[ $l - 1 ] + 1 ];
    next
        if $cells[ $positions[ $l - 1 ] + 1 ];
    $cells[ $positions[ $l - 1 ] ] = 0;
    $positions[ $l - 1 ]++;
    die "out of cell 2"
        if $positions[ $l - 1 ] >= $n;
    die "some one here"
        if $cells[ $positions[ $l - 1 ] ];
    $cells[ $positions[ $l - 1 ] ] = 1;
}

say join q{ }, map { $_ + 1 } @positions;

exit;
