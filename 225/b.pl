#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n - 1;

my %link;

for my $edge_ref ( @edges ) {
    my( $from, $to ) = @{ $edge_ref };
    $link{ $from }{ $to }++;
    $link{ $to }{ $from }++;
}

my $max = max map { scalar keys %{ $link{ $_ } } }
              keys %link;

say $max == ( $n - 1 ) ? "Yes" : "No";


exit;
