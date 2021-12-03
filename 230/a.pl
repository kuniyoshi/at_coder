#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
$n++
    if $n >= 42;

say sprintf "AGC%03d", $n;

exit;
