#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my @edges = <> );

my @links = map { [ ] } 1 .. $n;

for my $edge ( @edges ) {
    my( $a, $b ) = split m{\s}, $edge;
    push @{ $links[ $a ] }, $b;
    push @{ $links[ $b ] }, $a;
}

for my $i ( 0 .. $#links ) {
    my $link_ref = $links[ $i ];
    $links[ $i ] = [ sort { $b <=> $a } @{ $link_ref } ];
}

my @passed_cities = ( );
my %visited = ( );

dfs( 1 );

say join q{ }, @passed_cities;

exit;

sub dfs {
    my $city = shift;

    push @passed_cities, $city;
    $visited{ $city }++;

    while ( @{ $links[ $city ] } ) {
        my $other = pop @{ $links[ $city ] };

        next
            if $visited{ $other };

        dfs( $other );
        push @passed_cities, $city;
    }
}
