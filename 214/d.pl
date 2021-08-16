#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my @edge_strings = <> );

my %tree_of = ( 1 => get_first( @edge_strings ) );

my $total_cost = 0;

while ( %tres_of ) {
    my( $key, $u, $v ) = get_max_edge( @trees );
    my $tree = $tree_of{ $key };
    my $cost = $tree{ $u }{ $v };
    delete $tree{ $u }{ $v };
    delete
}

say $total_cost;

exit;

sub get_first {
    my @lines = @_;
    my %vertex = ( );
    my %edge = ( );

    for my $line ( @lines ) {
        my( $u, $v, $cost ) = split m{\s}, $line;
        $edge{ $u }{ $v } = $cost;
        $edge{ $v }{ $u } = $cost;
    }

    my $cursor;

    for my $u ( keys %edge ) {
        next
            if scalar( keys $edge{ $u } ) > 2;
        $cursor = $u;
        last;
    }

    die "No cursor found"
        unless defined $cursor;

    while ( $cursor ) {
        my $ref = delete $edge{ $cursor }
            or die "No edge";

    }


    return \@vertex;
}

__END__
[ u, p, { v => cost } ]
