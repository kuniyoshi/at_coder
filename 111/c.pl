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

push @odd_counts, [ undef, 0 ];
push @even_counts, [ undef, 0 ];

my $keeps = do {
    my( $greater_ref, $fewer_ref ) = align( \@odd_counts, \@even_counts );
    #warn "is same: ", $fewer_ref->[0][0] == $greater_ref->[0][0];
    shift @{ $fewer_ref }
        if $fewer_ref->[0][0] == $greater_ref->[0][0];
        #warn $greater_ref->[0][1];
        #warn $fewer_ref->[0][1];
    $greater_ref->[0][1] + $fewer_ref->[0][1];
};

say $n - $keeps;

exit;

sub align {
    my $a_ref = shift;
    my $b_ref = shift;
    if ( $a_ref->[0][1] == $b_ref->[0][1] ) {
        return $a_ref->[1][1] >= $b_ref->[1][1]
            ? ( $b_ref, $a_ref )
            : ( $a_ref, $b_ref );
    }
    return $a_ref->[0][1] >= $b_ref->[0][1]
        ? ( $a_ref, $b_ref )
        : ( $b_ref, $a_ref );
}
