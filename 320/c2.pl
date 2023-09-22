#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

chomp( my $m = <> );
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. 3;

my $min;

for ( my $i = 0; $i <= $m; ++$i ) {
    for ( my $j = 0; $j <= $m; ++$j ) {
        for ( my $k = 0; $k <= $m; ++$k ) {
            next
                if $i == $j || $i == $k || $j == $k;
            if ( $s[0][ $i % $m ] == $s[1][ $j % $m ] == $s[2][ $k % $m ] ) {
                my $t = max( $i, $j, $k );
                $min = min( $min // $t, $t );
            }
        }
    }
}

say $min // -1;

exit;
