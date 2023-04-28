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

die mod( 3, 4 );

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
    }

    if ( $op == 3 ) {
        say $mod;
    }
}

exit;

sub mod {
    my $top = shift;
    my $pow = shift;

    my @bits = split m{}, sprintf "%b", $pow;

    my $acc = 1;
    my @pows;
    push @pows, do { $acc *= 10; $acc %= $MOD }
        for @bits;

warn Dumper \@pows;

    my $result = 1;

    for ( my $i = 0; $i < @bits; ++$i ) {
        next
            unless $bits[ @bits - $i - 1 ];
        $result *= $pows[ $i ];
        $result %= $MOD;
    }

    return( ( $top * $result ) % $MOD );
}
