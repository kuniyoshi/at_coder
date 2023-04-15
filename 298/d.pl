#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MOD = 998244353;

chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my $z = 1;
my @values = ( 1 );
my @mods;

for my $ref ( @queries ) {
    my $op = $ref->[0];

    if ( $op == 1 ) {
        my $x = $ref->[1];
        $z *= 10;
        $z += $x;
        $z %= $MOD;
        push @values, $x;
        push @mods, ( @values[0] * 10 ** ( @values - 1 ) ) % $MOD;
    }

    if ( $op == 2 ) {
        $z = $MOD + $z - shift @mods;
        shift @values;
        $z %= $MOD;
    }

    if ( $op == 3 ) {
        say $z;
    }
}

exit;

sub mod {
    my $size = shift;
    my $y = 1;
    while ( $size-- ) {
        $y *= 10;
        $y %= $MOD;
    }
    return $y;
}
