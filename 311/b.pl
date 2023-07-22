#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $n, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

my @v = ( 1 ) x $d;


for ( my $i = 0; $i < @s; ++$i ) {
    for ( my $j = 0; $j < $d; ++$j ) {
        $v[ $j ] = 0
            if $s[ $i ][ $j ] ne q{o};
    }
}

my $s = join q{}, @v;

my @c = $s =~ m{(1+)}g;

say max( 0, map { length } @c );

exit;
