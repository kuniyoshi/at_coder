#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

my @borders = (
    ( map { $a[0][ $_ ] } 0 .. $n - 2 ),
    ( map { $a[ $_ ][ $n - 1 ] } 0 .. $n - 2 ),
    ( map { $a[ $n - 1 ][ $_ ] } reverse 1 .. $n - 1 ),
    ( map { $a[ $_ ][0] } reverse 1 .. $n - 1 ),
);

unshift @borders, pop @borders;

$a[0][ $_ ] = $borders[ ( $n - 1 ) * 0 + $_ ]
    for 0 .. $n - 2;
$a[ $_ ][ $n - 1 ] = $borders[ ( $n - 1 ) * 1 + $_ ]
    for 0 .. $n - 2;
$a[ $n - 1 ][ $_ ] = $borders[ ( $n - 1 ) * 2 + ( $n - $_ - 1 ) ]
    for 1 .. $n - 1;
$a[ $_ ][0] = $borders[ ( $n - 1 ) * 3 + ( $n - $_ - 1 ) ]
    for 1 .. $n - 1;

print map { join( q{}, @{ $_ } ), "\n" } @a;


exit;
