#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $k = <> );
my @chars = ( "A" .. "Z" );
say join q{}, @chars[ 0 .. $k - 1 ];

exit;
