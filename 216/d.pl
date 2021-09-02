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

my %colorsOf = ( );

for ( my $i = 0; $i < @k; ++$i ) {
    push @{ $colorsOf{ $k[ $i ][0] } }, $i;
}

while ( %colorsOf ) {
    my @shiftables = grep { @{ $colorsOf{ $_ } } > 1 } keys %colorsOf;

    last
        unless @shiftables;

    shift @{ $k[ $_ ] }
        for map { @{ $colorsOf{ $_ } } }
            @shiftables;

    %colorsOf = ( );

    for ( my $i = 0; $i < @k; ++$i ) {
        next
            unless @{ $k[ $i ] };
        push @{ $colorsOf{ $k[ $i ][0] } }, $i;
    }
}

say %colorsOf ? "No" : "Yes";

exit;
