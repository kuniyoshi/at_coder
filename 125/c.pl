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

my @r = ( $a[-1] );

for my $i ( reverse 0 .. $n - 2 ) {
    push @r, gcd( $a[ $i ], $a[ $i + 1 ] );
}

@r = reverse @r;

my $max = 1;

for my $i ( 0 .. $n - 1 ) {
    if ( $i == 0 ) {
        $max = max( $max, $r[1] );
        next;
    }

    if ( $i == $n - 1 ) {
        $max = max( $max, $l[ $i ] );
        next;
    }

    #    warn "gcd( $l[ $i ], $r[ -( $i + 1 ) ] ): ", gcd( $l[ $i ], $r[ -( $i + 1 ) ] );
    $max = max( $max, gcd( $l[ $i - 1 ], $r[ $i + 1 ] ) );
}

say $max;

exit;

sub gcd {
    my( $a, $b ) = @_;
    while ( $b ) {
        ( $a, $b ) = ( $b, $a % $b );
    }
    return $a;
}
