#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum max );

my( $n, $m, $q ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @queries = map { chomp; my @l = split m{\s}; $l[0]--; $l[1]--; \@l }
              map { scalar <> }
              1 .. $q;

say r( [ ] );

exit;

sub r {
    my $ref = shift;

    if ( @{ $ref } == $n ) {
        return sum( 0, map { $_->[3] } grep { $ref->[ $_->[1] ] - $ref->[ $_->[0] ] == $_->[2] } @queries );
    }

    my $max = 0;

    for my $i ( 1 .. $m ) {
        next
            if $i < ( $ref->[-1] // 0 );
        push @{ $ref }, $i;
        $max = max( $max, r( $ref ) );
        pop @{ $ref };
    }

    return $max;
}
