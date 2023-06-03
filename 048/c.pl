#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $n, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $previous = 0;
my $count = 0;

for my $a ( @a ) {
    my $eat = max( 0, ( $a + $previous ) - $x );
    $previous = $a - $eat;
    die "not be negative"
        if $previous < 0;
    $count += $eat;
}

say $count;

exit;
