#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use bigint;

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $wa = 0;
my $ac = 1e18 + 1;

while ( $ac - $wa > 1 ) {
    my $wj = int( ( $ac + $wa ) / 2 );
    if ( $b * $wj < $a ) {
        $wa = $wj;
    }
    else {
        $ac = $wj;
    }
}

say $ac;

exit;
