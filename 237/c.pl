#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };

my $cursor = $#s;
my $tail = 0;
$tail++
    while $cursor >= 0 && $s[ $cursor-- ] eq q{a};

$cursor = 0;
my $head = 0;
$head++
    while $cursor < @s && $s[ $cursor++ ] eq q{a};

    #warn "$tail - $head";
my $count = $tail - $head;

unshift @s, q{a}
    while $count-- >= 1;

    #warn join q{:}, @s;
for ( my $i = 0; $i < @s; ++$i ) {
    if ( $s[ $i ] ne $s[ $#s - $i ] ) {
        say "No";
        exit;
    }
}

say "Yes";

exit;
