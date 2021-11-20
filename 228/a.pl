#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $s, $t, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };

if ( $t < $s ) {
    $x = $x + 24
        if $x < $t;
    $t = $t + 24;
}

my $is = $x >= $s && $x < $t;

say $is ? "Yes" : "No";


exit;
