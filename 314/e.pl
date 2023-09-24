#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

# 3 14
# 100 2: 5 9        -> 7    -> 0.07
# 50 4:  1 2 4 8    -> 3.75 -> 0.075
# 70 5:  2 4 2 8 8  -> 4.8  -> 0.069

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @parameters = map { chomp; [ split m{\s} ] }
                 map { scalar <> }
                 1 .. $n;

my @e;

for ( my $i = 0; $i < $n; ++$i ) {
    my( $cost, undef, @points ) = @{ $parameters[ $i ] };
    $e[ $i ] = sum( @points ) / @points / $cost;
}

my $acc = 0;
my $paied = 0;

while ( $acc < $m ) {
    my $point = 0;
    my $min = $parameters[0][0];

    for ( my $i = 0; $i < $n; ++$i ) {
        if ( k
    }

    $acc += $point;
    $paied += $min;
}

say $paied;

exit;
