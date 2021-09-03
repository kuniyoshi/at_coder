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

my @queue = grep { @{ $colorsOf{ $_ } } == 2 } keys %colorsOf;

while ( @queue ) {
    my $color = shift @queue;
    my $poles_ref = delete $colorsOf{ $color };

    shift @{ $k[ $_ ] }
        for @{ $poles_ref };

    for my $pole ( @{ $poles_ref } ) {
        next
            unless @{ $k[ $pole ] };

        push @{ $colorsOf{ $k[ $pole ][0] } }, $pole;

        push @queue, $k[ $pole ][0]
            if @{ $colorsOf{ $k[ $pole ][0] } } == 2;
    }
}

say %colorsOf ? "No" : "Yes";

exit;
