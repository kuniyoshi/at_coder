#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $q ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @sequences = map { chomp; [ split m{\s} ] }
                map { scalar <> }
                1 .. $n;
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

for my $i ( 0 .. $#queries ) {
    my( $s, $t ) = @{ $queries[ $i ] };
    say $sequences[ $s - 1 ][ $t ];
}

exit;
