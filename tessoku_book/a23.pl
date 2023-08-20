#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = map { chomp; s{\s}{}g; eval "0b$_" }
        map { scalar <> }
        1 .. $m;

my @dp;

for my $a ( @a ) {
    $dp[ $a ] = 1;

    for ( my $i = 0; $i < @dp; ++$i ) {
        next
            unless defined $dp[ $i ];
        $dp[ $i | $a ] //= $dp[ $i ] + 1;
        $dp[ $i | $a ] = min( $dp[ $i | $a ], $dp[ $i ] + 1 );
    }
}

say $dp[ 2 ** $n - 1 ] // -1;

exit;

