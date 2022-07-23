#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $c ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @operations = map { chomp; [ split m{\s} ] }
                 map { scalar <> }
                 1 .. $n;

my $x = $c;
my $and = 

for ( my $i = 0; $i < $n; ++$i ) {
    my $op = $operations[ $i ][0];
}

exit;
