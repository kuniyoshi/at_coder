#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );

my @chars = split m{}, $s;

my $index = -1;

for my $i ( 0 .. $#chars ) {
    $index = $i + 1
        if $chars[ $i ] eq q{a};
}

say $index;

exit;
