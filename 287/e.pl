#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

my %count;

for my $s_ref ( @s ) {
    for ( my $i = 0; $i < @{ $s_ref }; ++$i ) {
        $count{ $s_ref->[ $i ] }++;
    }
}

exit;
