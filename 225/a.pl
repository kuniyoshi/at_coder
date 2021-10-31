#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $s = <> );
my @chars = split m{}, $s;
my %count;
$count{ $_ }++
    for @chars;

my $max = max values %count;
my %ans = (
    1 => 6,
    2 => 3,
    3 => 1,
);
say $ans{ $max };


exit;
