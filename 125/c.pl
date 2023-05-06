#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @l = ( $a[0] );

for my $i ( 1 .. $n - 1 ) {
    push @l, gcd( $a[ $i ], $l[ $i - 1 ] );
}

my @r;
$r[ $n - 1 ] = $a[-1];

for my $i ( reverse 0 .. $n - 2 ) {
    $r[ $i ] = gcd( $a[ $i ], $r[ $i + 1 ] );
}

my $max = 1;

for my $i ( 0 .. $n - 1 ) {
    my $gcd_l = $i - 1 >= 0 ? $l[ $i - 1 ] : undef;
    my $gcd_r = $i + 1 < $n ? $r[ $i + 1 ] : undef;
    $max = max( $max, gcd( $gcd_l // $gcd_r, $gcd_r // $gcd_l ) );
}

say $max;

exit;

sub gcd {
    my( $a, $b ) = @_;
    return $a > $b ? gcd_impl( $a, $b ) : gcd_impl( $b, $a );
}

sub gcd_impl {
    my( $a, $b ) = @_;
    while ( $b ) {
        ( $a, $b ) = ( $b, $a % $b );
    }
    return $a;
}
