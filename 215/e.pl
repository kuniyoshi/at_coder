#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $s = <> );

my @contests = map { ord( $_ ) - ord( "A" ) } split m{}, $s;

my %map = ( );

for ( my $i = 0; $i < @contests; ++$i ) {
    my $contest = $contests[ $i ];

    $map{ $contest } = [ ( 0 ) x $n ]
        unless $map{ $contest };

    my $r = $map{ $contest };

    $r->[ $i ] = 1;
}
warn Dumper \%map;

use bigint;

my $skips = 1;

for my $ref ( values %map ) {
    my @continuous_joins = ( );
    my @continuous_un_joins = ( );

    my $previous;
    my $continuous = 0;

    pop @{ $ref }
        while @{ $ref } && !$ref->[-1];
    shift @{ $ref }
        while @{ $ref } && !$ref->[0];

    push @{ $ref }, 0;

    for my $join ( @{ $ref } ) {
        $continuous++
            if $previous && $join;

        if ( $previous && !$join ) {
            push @continuous_joins, $continuous;
            $continuous = 0;
        }

        $previous = $join;
    }

    pop @{ $ref };

    $continuous = 0;
    $previous = 1;

    for my $join ( @{ $ref } ) {
        $continuous++
            if !$previous && !$join;

        if ( !$previous && $join ) {
            push @continuous_un_joins, $continuous;
            $continuous = 0;
        }

        $previous = $join;
    }

    warn "[", join( q{, }, @continuous_joins ), "]";

    for my $continous_join ( @continuous_joins ) {
        next
            if $continous_join < 2;
        $skips += 2 ** ( $continous_join - 1 );
    }

    warn "[", join( q{, }, @continuous_un_joins ), "]";

    for my $continuous_un_join ( @continuous_un_joins ) {
        $skips += 2 ** ( $continuous_un_join + 1 );
    }
}

my $total = 2 ** $n;
my $count = $total - $skips;
say $total;
say $skips;

say $count % 998244353;

exit;
