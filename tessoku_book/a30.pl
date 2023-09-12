#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MOD = 1000000007;

my( $n, $r ) = do { chomp( my $l = <> ); split m{\s}, $l };

say comb( $n, $r );

exit;

# nCr
# n! / (r! (n-r)!)
sub comb {
    my( $n, $r ) = @_;

    my $numerator = factorial( $n );
    my $denominator = factorial( $r ) * factorial( $n - $r );
    $denominator %= $MOD;

    my $result = 1;
    my $count = $MOD - 2;
    my $base = $denominator;
    while ( $count ) {
        if ( $count & 1 ) {
            $result *= $base;
            $result %= $MOD;
        }
        $base *= $base;
        $base %= $MOD;
        $count >>= 1;
    }

    $result *= $numerator;
    $result %= $MOD;

    return $result;
}

sub factorial {
    my $n = shift;
    my $result = 1;
    while ( $n ) {
        $result *= $n--;
        $result %= $MOD;
    }
    return $result;
}
