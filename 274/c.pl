#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @amebas;
$#amebas = 2 * $n + 1;

my %index = ( 1 => 1 );

for my $i ( 0 .. $n - 1 ) {
    my $a = $a[ $i ];
    my $index = $index{ $a }
        or die "Could not get index";
    my $name_left = ( $i + 1 ) * 2;
    my $name_right = ( $i + 1 ) * 2 + 1;
    my $index_left = $index * 2;
    my $index_right = $index * 2 + 1;

    $index{ $name_left } = $index_left;
    $index{ $name_right } = $index_right;
    #    $amebas[ $index_left ] = $name_left;
    #    $amebas[ $index_right ] = $name_right;
}

#my %count;

for my $i ( 1 .. 2 * $n + 1 ) {
    my $index = $index{ $i } // 1;
    #        or die "No data";

    my $current = $index;
    my $count = 0;
    while ( $current > 1 ) {
        $current = $current >> 1;
        $count++;
    }
    #    $count{ $i } = $count;

    say $count;
}

exit;
