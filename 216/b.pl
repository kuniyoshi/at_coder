#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my @names = map { <> } ( 1 .. $n ) );

my %count = ( );

$count{ $_ }++
    for @names;

my $is_same_same = grep { $_ > 1 } values %count;

say $is_same_same ? "Yes" : "No";


exit;
