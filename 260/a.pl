#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };

my %count;
$count{ $_ }++
    for @s;

my( $letter ) = grep { $count{ $_ } == 1 } keys %count;

say $letter // -1;

exit;
