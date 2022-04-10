#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );

my @numbers = r( $n );

say join q{ }, @numbers;

exit;

sub r {
    my $value = shift;

    return ( 1 )
        if $value == 1;

    return ( r( $value - 1 ), $value, r( $value - 1 ) );
}
