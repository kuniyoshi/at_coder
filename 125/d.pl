#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp = ( [ $a[0] ], [ -$a[0] ] );

for my $i ( 1 .. $n - 1 ) {
    $dp[0][ $i ] = max(
        $dp[0][ $i - 1 ] + $a[ $i ],
        $dp[1][ $i - 1 ] - $a[ $i ],
    );
    $dp[1][ $i ] = max(
        $dp[0][ $i - 1 ] - $a[ $i ],
        $dp[1][ $i - 1 ] + $a[ $i ],
    );
}

say $dp[0][ $n - 1 ];

exit;
