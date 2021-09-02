#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $line = <> );
my( $n, $m ) = split m{\s}, $line;
my @k = ( );

for my $i ( 1 .. $m ) {
    chomp( my $count = <> );
    chomp( my $numbers = <> );
    push @k, [ split m{\s}, $numbers ];
}

MAIN:
while ( @k ) {
    my $pair;

    LOOP:
    for ( my $i = 0; $i < @k; ++$i ) {
        for ( my $j = $i + 1; $j < @k; ++$j ) {
            next
                unless $k[ $j ][0] == $k[ $i ][0];

            $pair = [ $i, $j ];
            last LOOP;
        }
    }

    last MAIN
        unless $pair;

    shift @{ $k[ $_ ] }
        for @{ $pair };

    @k = grep { @{ $_ } } @k;
}

say @k ? "No" : "Yes";

exit;
