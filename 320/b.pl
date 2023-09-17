#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my @s = do { chomp( my $l = <> ); split m{}, $l };

my $max = 0;

for ( my $i = 0; $i < @s; ++$i ) {
    for ( my $j = $i; $j < @s; ++$j ) {
        if ( join( q{}, @s[ $i .. $j ] ) eq join( q{}, reverse @s[ $i .. $j ] ) ) {
            $max = max( $max, $j - $i + 1 );
        }
    }
}

say $max;

exit;
