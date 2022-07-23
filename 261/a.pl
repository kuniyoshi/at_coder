#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $l1, $r1, $l2, $r2 ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $left;
my $right;

if ( $l1 < $l2 ) {
    $left = [ $l1, $r1 ];
    $right = [ $l2, $r2 ];
}
else {
    $left = [ $l2, $r2 ];
    $right = [ $l1, $r1 ];
}

my $length = ( $right->[1] <= $left->[1] )
    ? ( $right->[1] - $right->[0] )
    : ( $left->[1] - $right->[0] );

say $length >= 0 ? $length : 0;

exit;
