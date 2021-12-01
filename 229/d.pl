#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );
chomp( my $k = <> );

my @s = map { $_ eq q{.} } split m{}, $s;
my $n = @s;

my $r = 0;
my $dots = 0;
my $max = 0;

for ( my $l = 0; $l < $n; ++$l ) {
    while ( $r < $n && $dots + $s[ $r ] <= $k ) {
        $dots = $dots + $s[ $r ];
        $r++;
    }
    my $continuous = $r - $l;
    $max = $continuous > $max ? $continuous : $max;
    $dots = $dots - $s[ $l ];
}

say $max;

exit;
