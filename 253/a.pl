#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

my( $a, $b, $c ) = do { chomp( my $l = <> ); split m{\s}, $l };

if ( $a == $b && $b == $c ) {
    say YesNo::get( 1 );
}
elsif ( $a == $b && $b != $c ) {
    say YesNo::get( 1 );
}
elsif ( $a != $b && $b == $c ) {
    say YesNo::get( 1 );
}
else {
    my( $min, $max ) = ( min( $a, $c ), max( $a, $c ) );
    say YesNo::get( $b > $min && $b < $max );
}

exit;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
