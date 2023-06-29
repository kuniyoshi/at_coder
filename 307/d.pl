#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $s = <> );
my @s = split m{}, $s;

my @levels;
my $acc = 0;

for my $s ( @s ) {
    if ( $s eq q{(} ) {
        $acc++;
    }
    elsif ( $s eq q{)} ) {
        $acc--;
    }

    push @levels, $acc;
}

for my $r_index ( reverse 0 .. $#s ) {
}

exit;
