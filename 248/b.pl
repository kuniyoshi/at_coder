#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use POSIX qw( ceil );

my( $a, $b, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $count = 0;
my $x = $a;

while ( $x < $b ) {
    $x = $x * $k;
    $count++;
}

say $count;

exit;
