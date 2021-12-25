#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @l = map { chomp; my @numbers = split m{\s}; shift @numbers; \@numbers }
        map { scalar <> }
        1 .. $n;

my $total = dfs( 0, 1 );

say $total;

exit;

sub dfs {
    my $index = shift;
    my $value = shift;

    return $value == $x
        if $index == @l;

    my $total = 0;

    for ( my $i = 0; $i < @{ $l[ $index ] }; ++$i ) {
        $total = $total + dfs( $index + 1, $value * $l[ $index ][ $i ] );
    }

    return $total;
}
