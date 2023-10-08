#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @results = map { chomp; [ split m{} ] }
              map { scalar <> }
              1 .. $n;

my @wins;

for ( my $i = 0; $i < @results; ++$i ) {
    $wins[ $i ] = grep { $_ eq q{o} } @{ $results[ $i ] };
}

say join q{ }, map { $_->[0] } sort { $b->[1] <=> $a->[1] } map { [ $_, $wins[ $_ - 1 ] ] } 1 .. $n;

exit;
