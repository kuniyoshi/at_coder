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

for my $f ( keys %tasty ) {
    $tasty{ $f } = [ sort { $a <=> $b } @{ $tasty{ $f } } ];
}

my @mosts = sort { $a <=> $b }
            map { $_->[-1] }
            values %tasty;

my $max = 0;
my @keys = keys %tasty;

for my $f ( grep { @{ $tasty{ $_ } } != 1 } @keys ) {
    my $ref = $tasty{ $f };
    $max = max( $max, $ref->[-1] + $ref->[-2] / 2 );
}

if ( %tasty > 1 ) {
    for my $f ( @keys ) {
        my $candidate = $tasty{ $f }[-1];

        if ( $candidate == $mosts[-1] ) {
            $candidate += $mosts[-2];
        }
        else {
            $candidate += $mosts[-1];
        }

        $max = max( $max, $candidate );
    }
}

say $max;

exit;
