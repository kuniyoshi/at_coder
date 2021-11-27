#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max min sum );

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };
my $large = max( $a, $b );
my $small = min( $a, $b );

my @larger_digits = reverse split m{}, $large;
my @smaller_digits = reverse split m{}, $small;

push @smaller_digits, 0
    while @smaller_digits < @larger_digits;

my $n = scalar @larger_digits;

for ( my $i = 0; $i < $n; ++$i ) {
    my $sum = sum( $smaller_digits[ $i ], $larger_digits[ $i ] );

    if ( $sum > 9 ) {
        say "Hard";
        exit;
    }
}

say "Easy";

exit;
