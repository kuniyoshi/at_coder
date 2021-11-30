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
    $acc++
        if $s eq q{.};
    push @dot_counts, $acc;
}

push @dot_counts, 0;

my $max = 0;

for ( my $i = 0; $i < $n; ++$i ) {
    if ( ( $dot_counts[ $n - 1 ] - $dot_counts[ $i - 1 ] ) <= $k ) {
        my $continuous = $n - $i;
        $max = $continuous > $max ? $continuous : $max;
        last;
    }

    my $ac = $i;
    my $wa = $n - 1;

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        my $dots = $dot_counts[ $wj ] - $dot_counts[ $i - 1 ];

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
