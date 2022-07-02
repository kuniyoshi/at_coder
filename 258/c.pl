#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $q ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = do { chomp( my $l = <> ); split m{}, $l };
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my $cursor = 0;

for my $ref ( @queries ) {
    my( $op, $x ) = @{ $ref };

    if ( $op == 1 ) {
        $cursor = ( $cursor + $x ) % $n;
    }
    else {
        say $s[ $x - 1 - $cursor ];
    }
}

exit;
