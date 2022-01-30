#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{}, $l };

my $a = [ undef, 0, undef ];
my $cursor = $a;

for ( my $i = 0; $i < @s; ++$i ) {
    my $new = [ undef, $i + 1, undef ];

    if ( $s[ $i ] eq q{L} ) {
        if ( !defined $cursor->[0] ) {
            $cursor->[0] = $new;
            $new->[2] = $cursor;
            $cursor = $new;
        }
        else {
            $new->[0] = $cursor->[0];
            $new->[2] = $cursor;
            $cursor->[0][2] = $new;
            $cursor->[0] = $new;
            $cursor = $new;
        }
    }
    else {
        if ( !defined $cursor->[2] ) {
            $new->[0] = $cursor;
            $cursor->[2] = $new;
            $cursor = $new;
        }
        else {
            $new->[0] = $cursor;
            $new->[2] = $cursor->[2];
            $cursor->[2][0] = $new;
            $cursor->[2] = $new;
            $cursor = $new;
        }
    }
}

my $root = $a;
$root = $root->[0]
    while defined $root->[0];

my @a;

$cursor = $root;

while ( defined $cursor->[2] ) {
    push @a, $cursor->[1];
    $cursor = $cursor->[2];
}

push @a, $cursor->[1];

say join q{ }, @a;

exit;
