#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @h = do { chomp( my $l = <> ); split m{\s}, $l };

my $cursor = 0;

while ( $cursor != $#h && $h[ $cursor ] < $h[ $cursor + 1 ] ) {
    $cursor++;
}

say $h[ $cursor ];

exit;
