#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum min );

my( $n, $d, $p ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @f = sort { $b <=> $a } do { chomp( my $l = <> ); split m{\s}, $l };

my $cost = 0;

while ( @f ) {
    my @pendings;

    push @pendings, shift @f
        while @f && @pendings < $d;

    my $sum = sum( @pendings );

    $cost += min( $p, $sum );
}

say $cost;

exit;
