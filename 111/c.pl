#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @v = do { chomp( my $l = <> ); split m{\s}, $l };

my %odd;
my %even;

for my $i ( 0 .. $n - 1 ) {
    my $ref = ( $i % 2 ? \%odd : \%even );
    $ref->{ $v[ $i ] }++;
}

my @odd_counts =  map { [ $_, $odd{ $_ }  ] } sort { $odd{ $b }  <=> $odd{ $a }  } keys %odd;
my @even_counts = map { [ $_, $even{ $_ } ] } sort { $even{ $b } <=> $even{ $a } } keys %even;

my $keeps = do {
    my( $greater_ref, $fewer_ref ) = $odd_counts[0][1] >= $even_counts[0][1]
        ? ( \@odd_counts, \@even_counts )
        : ( \@even_counts, \@odd_counts );
warn "is same: ", $fewer_ref->[0][0] == $greater_ref->[0][0];
    shift @{ $fewer_ref }
        if $fewer_ref->[0][0] == $greater_ref->[0][0];
    $fewer_ref = [ [ undef, 0 ] ]
       unless @{ $fewer_ref };
warn $greater_ref->[0][1];
warn $fewer_ref->[0][1];
    $greater_ref->[0][1] + $fewer_ref->[0][1];
};

say $n - $keeps;

exit;

