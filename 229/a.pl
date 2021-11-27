#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @cells = map { chomp; [ split m{} ] }
            map { scalar <> }
            1 .. 2;

my $blacks = scalar grep { $_ eq q{#} } map { @{ $_ } } @cells;

if ( $blacks == 4 ) {
    say "Yes";
    exit;
}

if ( $blacks == 3 ) {
    say "Yes";
    exit;
}

if ( $cells[0][0] eq q{#} && $cells[1][1] eq q{#} ) {
    say "No";
    exit;
}

if ( $cells[0][1] eq q{#} && $cells[1][0] eq q{#} ) {
    say "No";
    exit;
}

say "Yes";

exit;
