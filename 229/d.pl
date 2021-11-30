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
    if ( ( $dot_counts[ $n - 1 + 1 ] - $dot_counts[ $i ] ) <= $k ) {
        my $continuous = $n - $i;
        if ( $continuous > $max ) {
            warn "\$max goes: $continuous from $max";
        }
        $max = $continuous > $max ? $continuous : $max;
        next;
    }

    my $l = $i;
    my $r = $n - 1;

    my $count;

    while ( $r - $l > 1 ) {
        die
            if $count++ > 10;
        my $c = int( ( $l + $r ) / 2 );
        warn "$i - (l, r, c): ($l, $r, $c)";
        my $dots = $dot_counts[ $c + 1 ] - $dot_counts[ $i ];

        if ( $dots <= $k ) {
            $l = $c;
        }
        else {
            $r = $c;
        }
    }

    my $continuous = $l - $i + 1;

    if ( $continuous > $max ) {
        warn "\$max goes: $continuous from $max";
    }
    $max = $continuous > $max ? $continuous : $max;
}

say $max;

exit;
