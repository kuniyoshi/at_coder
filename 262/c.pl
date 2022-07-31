#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %appears;

my $answer = 0;

my $x = 0;
my %lists;

for my $j ( 1 .. $n ) {
    if ( $a[ $j - 1 ] == $j ) {
        $answer += $x;
        $x++;
        next;
    }

    # a[i] > a[j]
    # a[i] < j

    if ( $a[ $j - 1 ] <= $n ) {
        push @{ $lists{ $a[ $j - 1 ] } }, $j;
    }

    if ( $lists{ $j } ) {
        $answer += grep { $a[ $_ - 1 ] == $j } @{ $lists{ $j } };
    }
}

say $answer;

exit;
