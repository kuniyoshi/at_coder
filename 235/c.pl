#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $q ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @q = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $q;

my %count;

for ( my $i = 0; $i < @a; ++$i ) {
    push @{ $count{ $a[ $i ] } }, $i + 1;
}

for my $q_ref ( @q ) {
    my( $x, $k ) = @{ $q_ref };
    say $count{ $x }[ $k - 1 ] // -1;
}

exit;
