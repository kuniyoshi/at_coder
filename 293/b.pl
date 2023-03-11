#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %called;

for my $i ( 0 .. $n - 1 ) {
    next
        if $called{ $i + 1 };
    $called{ $a[ $i ] }++;
}

say $n - %called;
say join q{ }, grep { !$called{ $_ } } 1 .. $n;


exit;
