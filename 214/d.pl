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
        my $cost = f( $i, $j, $i, );
        warn "\$cost: $cost ($i, $j)";
        $total += $cost;
    }
}

say $total;

exit;

sub f {
    my( $u, $v, $parent ) = @_;

    return $edge{ $u }{ $v }
        if $edge{ $u }{ $v };

    my $max = -1;
    warn Dumper \%edge
        if $u == 4 && $v == 5;

    for my $p ( keys %{ $edge{ $u } } ) {
        next
            if $p == $parent;

        my $value = max( $edge{ $u }{ $p }, f( $p, $v, $u ) );
        $edge{ $u }{ $p } = $value;
        $max = $value
            if $value > $max;
    }

    $edge{ $u }{ $v } = $max;
    $edge{ $v }{ $u } = $max;

    return $max;
}

sub max {
    my( $a, $b ) = @_;
    return $a
        if $a > $b;
    return $b;
}
