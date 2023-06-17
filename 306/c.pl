#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %count;
my @result;

for my $i ( 0 .. 3 * $n - 1 ) {
    push @result, $a[ $i ]
        if ++$count{ $a[ $i ] } == 2;
}

say join q{ }, @result;

exit;
