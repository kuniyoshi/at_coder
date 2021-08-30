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

while ( @k ) {
    my @sorted = sort { @{ $b } <=> @{ $a } } @k;
    my $number = $sorted[0][0];
    my $pair;
    for ( my $i = 1; $i < @sorted; ++$i ) {
        next
            unless $sorted[ $i ][0] == $number;
        $pair = $i;
        last;
    }
    last
        unless defined $pair;
    shift @{ $sorted[0] };
    shift @{ $sorted[ $pair ] };
    my $both_contains = @{ $sorted[0] } && @{ $sorted[ $pair ] };
    @k = grep { @{ $_ } } @k
        unless $both_contains;
}

say @k ? "No" : "Yes";

exit;
