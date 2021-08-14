#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my @edge_strings = <> );

my %edge = ( );

for my $line ( @edge_strings ) {
    my( $u, $v, $w ) = split m{\s}, $line;
    $edge{ $u }{ $v } = $w;
    $edge{ $v }{ $u } = $w;
}

my $total = 0;

for my $i ( 1 .. $n - 1 ) {
    for my $j ( $i + 1 .. $n ) {
        $total += f( $i, $j, 0 );
    }
}

say $total;

exit;

sub f {
    my( $u, $v, $cost ) = @_;

    return $edge{ $u }{ $v }
        if $edge{ $u }{ $v };

    my $max = -1;

    for my $p ( values %{ $edge{ $u } } ) {
        my $value = f( $p, $v, $cost + $edge{ $u }{ $p } );
        $max = $value
            if $value > $max;
    }

    $edge{ $u }{ $v } = $max;

    return $max;
}
