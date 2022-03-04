#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Memoize;

memoize( "r" );

my( $n, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @jumps = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

say r( 0, 0 ) ? "Yes" : "No";

exit;

sub r {
    my $times = shift;
    my $target = shift;

    return $target == $x
        if $times == $n;

    return r( $times + 1, $target + $jumps[ $times ][0] )
        || r( $times + 1, $target + $jumps[ $times ][1] );
}
