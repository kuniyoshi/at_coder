#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @p = do { chomp( my $l = <> ); split m{\s}, $l };
unshift @p, 0;

my $count = 0;
my $cursor = $n - 1;

while ( $cursor != 0 ) {
    my $parent = $p[ $cursor ];
    $cursor = $parent - 1;
    $count++;
}


say $count;

exit;
