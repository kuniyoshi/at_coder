#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %count;
$count{ $_ % 100 }++
    for @a;

my $total = 0;

for ( my $i = 0; $i <= 50; ++$i ) {
    next
        unless $count{ $i };

    if ( $i == 0 || $i == 50 ) {
        $total += $count{ $i } * ( $count{ $i } - 1 ) / 2;
    }
    else {
        $total += $count{ $i } * $count{ 100 - $i };
    }
}

say $total;

exit;
