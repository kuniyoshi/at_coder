#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Test::More;

ok( nearly_equal( 1, 1 ) );
ok( !nearly_equal( 2, 1 ) );
ok( nearly_equal( 1.000001, 1 ) );
ok( !nearly_equal( 1.00001, 1 ) );
ok( nearly_equal( 100000.1, 100000 ) );
ok( !nearly_equal( 1, 0 ) );



done_testing( );


exit;

sub nearly_equal {
    my( $a, $b ) = @_;
    if ( !$a || !$b ) {
        return abs( $b - $a ) < 1e-5;
    }
    my $diff = abs( $b - $a ) / $b;
    return $diff < 1e-5;
}

sub get {
}
