#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum max );

chomp( my $n = <> );
my @p = map { chomp; $_ }
        map { scalar <> }
        1 .. $n;

my $sum = sum( @p );
my $max = max( @p );

say $sum - $max / 2;

exit;
