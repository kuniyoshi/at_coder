#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $t = <> );

for ( my $i = 0; $i < $t; ++$i ) {
    my( $n, $x, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
    solve( $n, $x, $k );
}
my @s = do { chomp( my $l = <> ); split m{\s}, $l };
my @l = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $n;

exit;
