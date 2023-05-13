#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum min );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $total = sum( map { abs } @a );
my( $min ) = sort { $a <=> $b } map { abs } @a;
my $negatives = grep { $_ < 0 } @a;

if ( $negatives % 2 ) {
    say $total - 2 * $min;
}
else {
    say $total;
}

exit;
