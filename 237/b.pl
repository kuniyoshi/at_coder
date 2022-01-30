#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $h;

my @b;

for ( my $i = 0; $i < $w; ++$i ) {
    for ( my $j = 0; $j < $h; ++$j ) {
        $b[ $i ][ $j ] = $a[ $j ][ $i ];
    }
}

say join q{ }, @{ $_ } for @b;

exit;
