#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

for my $ref ( @queries ) {
    printf "%.10f %.10f %.10f\n", brute( @{ $ref } );
}

exit;

sub brute {
    my( $x, $y, $z, $t ) = @_;
    my $a = 1;
    my $b = 1;
    my $c = 1;

    for my $i ( 1 .. $t ) {
        my $na = ( 1 - $x ) * $a + $y * $b;
        my $nb = ( 1 - $y ) * $b + $z * $c;
        my $nc = ( 1 - $z ) * $c + $x * $a;
        $a = $na;
        $b = $nb;
        $c = $nc;
    }

    return $a, $b, $c;
}
