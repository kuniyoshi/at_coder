#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use bigint;

chomp( my $n = <> );

my @operations = ( );

while ( $n ) {
    push @operations, 0
        if $n % 2;
    push @operations, 1
        if $n > 1;
    $n >>= 1;
}

say join q{}, map { chr( $_ + ord( "A" ) ) } reverse @operations;

exit;
