#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $t = <> );

PROBLEM:
while ( $t-- ) {
    chomp( my $n = <> );
    chomp( my @lines = ( map { scalar <> } 1 .. $n ) );
    my @ranges = sort { $b->[0] <=> $a->[0] }
                 map  { [ split m{\s}, $_ ] }
                 @lines;

    my $cursor = 0;

    for my $range_ref ( @ranges ) {
    }

    say "yes";
}


exit;

