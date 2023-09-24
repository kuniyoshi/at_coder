#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $s = <> );
my @c = do { chomp( my $l = <> ); split m{\s}, $l };

my @tuples;
my %colors;

for ( my $i = 0; $i < $n; ++$i ) {
    my $ref = [ $i, substr( $s, $i, 1 ), $c[ $i ] ];
    push @tuples, $ref;
    push @{ $colors{ $c[ $i ] } }, $ref;
}

my @results;

for my $color ( keys %colors ) {
    my $ref = $colors{ $color };
    my @indexes = map { $_->[0] } @{ $ref };
    my @chars = map { $_->[1] } @{ $ref };
    unshift @chars, pop @chars;

    $results[ $indexes[ $_ ] ] = $chars[ $_ ]
        for 0 .. $#{ $ref };
}

say join q{}, @results;

exit;
