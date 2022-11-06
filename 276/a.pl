#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( first );

chomp( my $s = <> );

my @chars = split m{}, $s;

my $index  = first { $chars[ $_ - 1 ] eq q{a} }
             reverse 1 .. @chars;

say $index // -1;

exit;
