#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @cells = map { chomp; [ split m{} ] }
            map { scalar <> }
            1 .. $h;

my @dp = ( [ 1 ] );

for ( my $i = 0; $i < $h; ++$i ) {
    for ( my $j = 0; $j < $w; ++$j ) {
        next
            unless defined $dp[ $i ][ $j ];
        next
            if $cells[ $i ][ $j ] eq q{#};
        if ( $i < $h - 1 ) {
            $dp[ $i + 1 ][ $j ] += $dp[ $i ][ $j ];
        }
        if ( $j < $w - 1 ) {
            $dp[ $i ][ $j + 1 ] += $dp[ $i ][ $j ];
        }
    }
}

say $dp[ $h - 1 ][ $w - 1 ] // 0;


exit;
