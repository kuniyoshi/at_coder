#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w, $x, $y ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

$x--;
$y--;

my @directions = (
    [ 0, 1 ],
    [ 1, 0 ],
    [ 0, -1 ],
    [ -1, 0 ],
);

my $seen = 1;

for my $ref ( @directions ) {
    my $step = 1;
    while ( is_in( $ref, $step ) ) {
        warn join q{:}, $ref->[0] * $step, $ref->[1] * $step;
        $step++;
        $seen++;
    }
}

say $seen;

exit;

sub is_in {
    my( $di, $dj ) = @{ shift( ) };
    my $step = shift;
    my $ci = $y + $di * $step;
    my $cj = $x + $dj * $step;
    return
        if !with_in( $ci, $h ) || !with_in( $cj, $w );
    return $s[ $ci ][ $cj ] eq q{.};
}

sub with_in {
    my $i = shift;
    my $max = shift;
    return $i >= 0 && $i < $max;
}
