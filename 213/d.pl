#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my @edges = <> );

my %city_of = ( );

for my $edge ( @edges ) {
    my( $a, $b ) = split m{\s}, $edge;
    my $a_index = $a - 1;
    my $b_index = $b - 1;

    my( $min, $max ) = minmax( $a_index, $b_index );

    $city_of{ $min } = { }
        if !exists $city_of{ $min };

    my $ref = $city_of{ $min };
    $ref->{ $max }++;
}

#die Dumper \%city_of;

my $current_city = 0;
my @passed_cities = ( $current_city );
my @stack = ( $current_city );

while ( 1 ) {
    my $edges_ref = $city_of{ $current_city } // { };

    last
        if $current_city == 0 && !%{ $edges_ref };

    if ( !%{ $edges_ref } ) {
        pop @stack
            if $stack[-1] == $current_city;

        $current_city = @stack ? pop @stack : 0;
        push @passed_cities, $current_city;

        next;
    }

    my @candidates = sort { $a <=> $b } keys %{ $edges_ref };
    $current_city = $candidates[0];
    delete $edges_ref->{ $current_city };
    push @passed_cities, $current_city;
    push @stack, $current_city;
}

say join q{ }, map { $_ + 1 } @passed_cities;


exit;

sub minmax {
    my( $a, $b ) = @_;
    return ( $a, $b )
        if $a < $b;
    return ( $b, $a );
}
