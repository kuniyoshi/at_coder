#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $n = <> );
my @c = do { chomp( my $l = <> ); split m{\s}, $l };

my @numbers;

my $min = min( @c );
my $k = int( $n / $min );
my $remain = $n;

while ( $k ) {
    for my $i ( reverse 1 .. 9 ) {
        next
            if $remain < $c[ $i - 1 ];
        my $new_k = int( ( $remain - $c[ $i - 1 ] ) / $min );
        next
            if $new_k != $k - 1;
        push @numbers, $i;
        $remain -= $c[ $i - 1 ];
        last;
    }
    $k--;
}

say join q{}, @numbers;

exit;
