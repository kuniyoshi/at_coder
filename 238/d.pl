#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Memoize;

memoize( "test" );

chomp( my $t = <> );
my @q = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $t;

for my $q_ref ( @q ) {
    my( $a, $s ) = @{ $q_ref };
    my $has = test( $a, $s );
    say $has ? "Yes" : "No";
}

exit;

sub test {
    my( $and, $sum ) = @_;

    return $and == 0
        if $sum == 0;

    my $a = $and & 1;

    for my $x ( 0 .. 1 ) {
        for my $y ( 0 .. 1 ) {
            next
                if $a != ( $x & $y );
            next
                if ( ( $sum - $x - $y ) < 0 );
            next
                if ( ( ( $sum - $x - $y ) % 2 ) != 0 );
            return 1
                if test( $and >> 1, ( $sum - $x - $y ) >> 1 );
        }
    }

    return;
}
