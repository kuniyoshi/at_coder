#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );

$n =~ s{(\d{3})(\d+)}{$1 . "0" x length($2)}e;

say $n;

exit;

