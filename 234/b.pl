#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @points = map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. $n;

my $max = 0;

for ( my $i = 0; $i < $n; ++$i ) {
    for ( my $j = 0; $j < $i; ++$j ) {
        my $length = sqrt( ( $points[ $i ][0] - $points[ $j ][0] ) ** 2 + ( $points[ $i ][1] - $points[ $j ][1] ) ** 2 );
        $max = $length > $max ? $length : $max;
    }
}

say $max;

exit;
