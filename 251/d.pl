#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $w = <> );

my @results;

while ( $w ) {
    my %count;

    for my $i ( 1 .. $w ) {
        my $j = $w - $i;
        last
            if $i >= $j;
        $count{ $i }++;
        $count{ $j }++;
    }

    last
        unless %count;

    my( $max_ref ) = sort { $b->[1] <=> $a->[1] } map { [ $_, $count{ $_ } ] } keys %count;
    push @results, $max_ref->[0];
    $w -= $max_ref->[0];
}

say scalar @results;
say join q{ }, @results;

exit;
