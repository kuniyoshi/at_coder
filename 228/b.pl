#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my ( $n, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %knew;

my $count = 0;

while ( !$knew{ $x }++ ) {
    $x = $a[ $x - 1 ];
    $count++;
}

say $count;

exit;
