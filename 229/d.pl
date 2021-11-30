#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );
chomp( my $k = <> );

my @s = split m{}, $s;
my $n = scalar @s;

push @s, ( ( q{.} ) x $k );

my @dot_counts;
my $acc = 0;

for my $s ( @s ) {
    push @dot_counts, $acc;
    $acc++
        if $s eq q{.};
}

push @dot_counts, $acc;

my $max = 0;

for ( my $i = 0; $i < $n; ++$i ) {
    my $l = $i;
    my $r = $#s;

    while ( $l < $r ) {
        my $c = int( ( $l + $r ) / 2 );
        my $dots = $dot_counts[ $c + 1 ] - $dot_counts[ $i ];
        if ( $dots 
    }
    my $max = 
}

say $max;

exit;
