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
        $max = $continuous > $max ? $continuous : $max;
        last;
    }

    my $ac = $i;
    my $wa = $n - 1;

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        my $dots = $dot_counts[ $wj + 1 ] - $dot_counts[ $i ];

        if ( $dots <= $k ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    my $continuous = $ac - $i + 1;
    $max = $continuous > $max ? $continuous : $max;
}

say $max;

exit;
