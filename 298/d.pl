#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Memoize qw( memoize );

memoize( "mod" );

my $MOD = 998244353;

chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my @values = ( 1 );
my $mod = 1;

for my $ref ( @queries ) {
    my $op = $ref->[0];

    if ( $op == 1 ) {
        my $x = $ref->[1];
        $mod *= 10;
        $mod += $x;
        $mod %= $MOD;
        push @values, $x;
    }

    if ( $op == 2 ) {
        my $top = shift @values;
        $mod -= mod( $top, scalar @values );
        if ( $mod < 0 ) {
            $mod += $MOD;
        }
    }

    if ( $op == 3 ) {
        say $mod;
    }
}

exit;

sub mod {
    my $top = shift;
    my $pow = shift;

    my $result = $top;
    my $base = 10;

    while ( $pow ) {
        if ( $pow % 2 ) {
            $result *= $base;
            $result %= $MOD;
        }
        $base *= $base;
        $base %= $MOD;
        $pow >>= 1;
    }

    return $result;
}
