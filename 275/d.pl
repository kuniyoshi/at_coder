#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Memoize;

memoize( "f" );

chomp( my $n = <> );

say f( $n );

exit;

sub f {
    my $x = shift;
    return 1
        if $x == 0;

    return f( int( $x / 2 ) ) + f( int( $x / 3 ) );
}
