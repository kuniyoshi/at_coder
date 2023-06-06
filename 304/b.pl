#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );

say p2( $n );

exit;

sub p1 {
    my $n = shift;

    my $length = length $n;

    while ( length( $n ) > 3 ) {
        $n = int( $n / 10 );
    }

    while ( length( $n ) != $length ) {
        $n *= 10;
    }

    return $n;
}

sub p2 {
    my $n = shift;

    return $n
        if $n < 1000;

    my $length = length $n;

    return int( $n / ( 10 ** ( $length - 3 ) ) ) * 10 ** ( $length - 3 );
}
