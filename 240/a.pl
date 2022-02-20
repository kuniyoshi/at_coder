#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

if ( $b == 10 ) {
    my $is = $a == 1 || $a == 9;
    say $is ? "Yes" : "No";
    exit;
}

say $a + 1 == $b ? "Yes" : "No";

exit;
