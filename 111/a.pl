#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
$n =~ s{([19])}{$1 eq "1" ? "9" : "1"}eg;

say $n;

exit;
