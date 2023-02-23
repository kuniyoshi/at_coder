#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = do { chomp( my $l = <> ); split m{}, $l };

my @passes = map { $_->[1] } grep { $_->[0] eq q{o} } map { [ $s[ $_ ], $_ ] } 0 .. $#s;
die "index"
    unless defined $#passes;
die "k"
    unless defined $k;
$#passes = $k - 1
    if @passes > $k;
my %pass = ( );
$pass{ $_ }++
    for @passes;

say join q{}, map { $pass{ $_ } ? q{o} : q{x} } 0 .. $#s;

exit;
