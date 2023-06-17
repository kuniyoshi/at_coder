#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @courses = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $n;

my $poisoned = 0;
my $healthy = 0;

for my $ref ( @courses ) {
    my( $poisonous, $tasty ) = @{ $ref };
    if ( $poisonous ) {
        $poisoned = max( $healthy + $tasty, $poisoned );
    }
    else {
        $healthy = max( $poisoned + $tasty, $healthy, $healthy + $tasty );
    }
}

say max( $healthy, $poisoned );

exit;
