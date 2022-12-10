#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum max );

my( $n, $k, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $max;

for my $i ( 0 .. 2 ** $n ) {
    my @bits = reverse split m{}, sprintf "%b", $i;
    my $selection = grep { $_ } @bits;
    next
        if $selection != $k;
    next
        if @bits > @a;

    my $total = sum( @a[ grep { $bits[ $_ ] } 0 .. $#bits ] );
    next
        if $total % $d;

    warn "### $total";
    warn Dumper \@bits;
    $max = max( $max // $total, $total );
}

say $max // -1;


exit;

