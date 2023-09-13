#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MOD = 1_000_000_007;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };

# ( H + W - 2 )! / ( ( W - 1 )! ( H - 1 )! )

my $numerator = factorial( $h + $w - 2 );
my $denominator = factorial( $w - 1 ) * factorial( $h - 1 );
$denominator %= $MOD;

my $result = $numerator * power( $denominator, $MOD - 2 );
$result %= $MOD;

say $result;

exit;

sub power {
    my( $a, $b ) = @_;
    my $result = 1;
    my $base = $a;

    while ( $b ) {
        if ( $b & 1 ) {
            $result *= $base;
            $result %= $MOD;
        }
        $base *= $base;
        $base %= $MOD;
        $b >>= 1;
    }

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
