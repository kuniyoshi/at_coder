#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $l, $r ) = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $s = <> );

$l--;
$r--;

my @s = split m{}, $s;
my $answer = join q{}, @s[ 0 .. $l - 1, reverse( $l .. $r ), $r + 1 .. $#s ];
say $answer;

exit;
