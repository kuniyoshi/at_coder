#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

my( $x, $a, $d, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $first = $a;
my $last = $a + $d * ( $n - 1 );
my $min = min( $first, $last );
my $max = max( $first, $last );

if ( $x <= $min ) {
    say $min - $x;
    exit;
}

if ( $x >= $max ) {
    say $x - $max;
    exit;
}

die "d == 0 should be determined avobe"
    if $d == 0;

my $base = int( ( $x - $a ) / $d );
my $left = $base - $d;
my $right = $base + $d;

say min( abs( $left - $x ), abs( $right - $x ) );

__END__
warn "will die" unless $d;
$x -= $first;
my $mod = abs( $x ) % $d;

say min( $mod, abs( $d - 1 - $mod ) );

exit;
