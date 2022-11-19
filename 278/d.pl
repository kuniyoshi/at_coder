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

my $base = 0;

for my $ref ( @queries ) {
    my $operation = shift @{ $ref };
    if ( $operation == 1 ) {
        my $x = shift @{ $ref };
        @a = ( );
        $base = $x;
    }
    elsif ( $operation == 2 ) {
        my( $i, $x ) = @{ $ref };
        $a[ $i - 1 ] = ( $a[ $i - 1 ] // $base ) + $x;
    }
    elsif ( $operation == 3 ) {
        my $i = shift @{ $ref };
        say $a[ $i - 1 ] // $base;
    }
    else {
        die "Unknown operation: $operation";
    }
}

exit;
