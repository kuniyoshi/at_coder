#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $s ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @cards = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

unshift @cards, [ 0, 0 ];

my @dp = ( [ 1 ] );

for my $i ( 1 .. $n ) {
    for my $j ( 0 .. $s ) {
        if ( $dp[ $i - 1 ][ $j ] ) {
            for my $value ( @{ $cards[ $i ] } ) {
                $dp[ $i ][ $j + $value ]++;
            }
        }
    }
}

if ( !$dp[ $n ][ $s ] ) {
    say YesNo::get( 0 );
    exit;
}

my @flips;
my $cursor = $s;

for my $i ( reverse 1 .. $n ) {
    die "somehow"
        if !$dp[ $i ][ $cursor ];

    if ( $dp[ $i - 1 ][ $cursor - $cards[ $i ][0] ] ) {
        push @flips, "H";
        $cursor -= $cards[ $i ][0];
        next;
    }

    if ( $dp[ $i - 1 ][ $cursor - $cards[ $i ][1] ] ) {
        push @flips, "T";
        $cursor -= $cards[ $i ][1];
        next;
    }

    die "somehow";
}

say YesNo::get( 1 );
say join q{}, reverse @flips;

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
