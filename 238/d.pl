#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $t = <> );
my @q = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $t;

for my $q_ref ( @q ) {
    my( $a, $s ) = @{ $q_ref };
    my @a = split m{}, sprintf "%b", $a;
}

exit;
