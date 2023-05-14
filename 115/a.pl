#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $d = <> );

my @parts = qw( Christmas );

push @parts, "Eve"
    while $d++ < 25;

say join q{ }, @parts;

exit;
