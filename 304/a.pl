#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $n = <> );
my @people = map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. $n;

my $min = 0;

for ( my $i = 0; $i < $n; ++$i ) {
    $min = $people[ $i ][1] < $people[ $min ][1] ? $i : $min;
}

print map { $_, "\n" } map { $_->[0] } @people[ ( $min .. $#people ), ( 0 .. ( $min - 1 ) ) ];

exit;
