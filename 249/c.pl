#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

my $max = 0;

for my $selection ( 0 .. ( 2 ** $n - 1 ) ) {
    DEBUG: {
        my $width = 1 + int( log( $n ) / log( 2 ) + 0.5 );
        #        warn sprintf "%0${n}b", $selection;
    }

    my $current = $selection;
    my $nth = 0;
    my @counts;

    while ( $current ) {
        if ( $current & 1 ) {
            #            warn "select $nth";
            for my $letter ( @{ $s[ $nth ] } ) {
                $counts[ ord( $letter ) - ord( "a" ) ]++;
            }
        }

        $nth++;
        $current >>= 1;
    }

    $max = max( $max, scalar grep { defined && $_ == $k } @counts )
        if @counts;
}

say $max;

exit;
