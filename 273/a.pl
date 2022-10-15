#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );

say f( $n );

exit;

sub f {
    my $k = shift;
    return 1
        if $k == 0;
    return $k * f( $k - 1 );
}
