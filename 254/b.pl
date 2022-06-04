#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );

my @a;

for my $i ( 0 .. $n - 1 ) {
    my @b;
    for my $j ( 0 .. $i ) {
        my $a = ( $j == 0 || $j == $i )
            ? 1
            : $a[ $i - 1 ][ $j - 1 ] + $a[ $i - 1 ][ $j ];
        push @b, $a;
    }
    say join q{ }, @b;
    push @a, \@b;
}

exit;
