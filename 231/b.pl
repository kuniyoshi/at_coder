#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = map { chomp( my $l = scalar <> ); $l }
        1 .. $n;

my %count;
$count{ $_ }++
    for @s;

my( $anster ) = map { $_->[0] }
                sort { $b->[1] <=> $a->[1] }
                map { [ $_ => $count{ $_ } ] }
                keys %count;

say $anster;

exit;
