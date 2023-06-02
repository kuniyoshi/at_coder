#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $c = <> );

my $is = grep { $_ eq $c } qw( a i u e o );

say $is ? "vowel" : "consonant";

exit;
