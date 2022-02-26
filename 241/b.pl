#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $m, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = do { chomp( my $l = <> ); split m{\s}, $l };

my %count;
$count{ $_ }++
    for @a;

for $b ( @b ) {
    if ( !$count{ $b } || $count{ $b } < 1 ) {
        say "No";
        exit;
    }
    $count{ $b }--;
}

say "Yes";

exit;
