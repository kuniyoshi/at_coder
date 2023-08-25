#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max sum );

chomp( my $n = <> );
my @fs = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $n;

my %tasty;

for my $ref ( @fs ) {
    my( $f, $s ) = @{ $ref };
    push @{ $tasty{ $f } }, $s;
}

my @keys = keys %tasty;

for my $f ( @keys ) {
    $tasty{ $f } = [ sort { $a <=> $b } @{ $tasty{ $f } } ];
}

my( $most_ref ) = sort { $b->[1] <=> $a->[1] }
                  map { [ $_, $tasty{ $_ }[-1] ] }
                  @keys;

my $max = 0;

for my $f ( @keys ) {
    if ( $f == $most_ref->[0] ) {
        $max = max( $max, $most_ref->[1] + $tasty{ $f }[-2] / 2 )
            if @{ $tasty{ $f } } > 1;
    }
    else {
        $max = max( $max, $most_ref->[1] + $tasty{ $f }[-1] );
    }
}

say $max;

exit;
