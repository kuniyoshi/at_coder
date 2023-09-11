#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MOD = 1000000007;

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $result = 1;

while ( $b ) {
    if ( $b & 1 ) {
        $result *= $a;
        $result %= $MOD;
    }
    $a *= $a;
    $a %= $MOD;
    $b >>= 1;
}

say $result;

exit;
