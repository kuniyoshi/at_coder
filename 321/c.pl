#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $k = <> );

my @numbers = ( 0 );

# 9 8 7 6 5 4 3 2 1 0
for ( my $i = 0; $i < 2 ** 10; ++$i ) {
    my @values = grep { $i & 1 << $_ } reverse 0 .. 9;
    push @numbers, join q{}, @values
        if @values;
}

@numbers = sort { $a <=> $b } @numbers;

say $numbers[ $k + 1 ];

exit;
