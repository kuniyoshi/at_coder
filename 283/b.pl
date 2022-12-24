#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

for my $ref ( @queries ) {
    my $op = shift @{ $ref };
    if ( $op == 1 ) {
        my( $k, $x ) = @{ $ref };
        $a[ $k - 1 ] = $x;
    }
    else {
        my $k = shift @{ $ref };
        say $a[ $k - 1 ];
    }
}

exit;
