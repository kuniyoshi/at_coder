#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };

my @accs = map { [ 0 ] } 0 .. 9;

for my $i ( 0 .. $#s ) {
    for my $j ( 0 .. 9 ) {
        $accs[ $j ][ $i + 1 ] = ( $accs[ $j ][ $i ] + ( $j == $s[ $i ] ) ) % 2;
    }
}

#say join q{, }, @{ $_ }
#    for @accs;
#die;

my @values;

for my $i ( 0 .. @s ) {
    $values[ $i ] = 0;
    $values[ $i ] += $accs[ $_ ][ $i ] << $_
        for 0 .. 9;
}

die Dumper \@values;

exit;
