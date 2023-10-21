#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @offices = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $n;

my $max = 0;

for ( my $i = 0; $i < 24; ++$i ) {
    my $total = 0;

    for ( my $j = 0; $j < $n; ++$j ) {
        $total += t( $i, $offices[ $j ] );
    }

    $max = max( $max, $total );
}

say $max;

exit;

sub t {
    my $h = shift;
    my $ref = shift;
    my( $w, $x ) = @{ $ref };
    my $area_hour = ( $x + $h ) % 24;
    if ( $area_hour >= 9 && $area_hour <= 17 ) {
        return $w;
    }
    return 0;
}
