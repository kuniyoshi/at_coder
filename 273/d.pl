#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

my( $h, $w, $rs, $cs ) = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $n = <> );
my @walls = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;
chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my %walls;

for my $ref ( @walls ) {
    push @{ $walls{row}{ $ref->[0] } }, $ref->[1];
    push @{ $walls{col}{ $ref->[1] } }, $ref->[0];
}

for my $direction ( keys %walls ) {
    for my $value ( keys %{ $walls{ $direction } } ) {
        $walls{ $direction }{ $value } = [ sort { $a <=> $b } @{ $walls{ $direction }{ $value } } ];
        $walls{ "reverse_$direction" }{ $value } = [ sort { $b <=> $a } @{ $walls{ $direction }{ $value } } ];
    }
}

my @current = ( $rs, $cs );

for my $ref ( @queries ) {
    my( $d, $l ) = @{ $ref };
    #warn "### ($d, $l)";

    if ( $d eq q{L} ) {
        $current[1] = get_previous( $current[1], $walls{row}{ $current[0] }, $l );
        #warn "--- $current[1]";
    }
    if ( $d eq q{R} ) {
        $current[1] = get_next( $current[1], $walls{row}{ $current[0] }, $l, $w );
        #warn "--- $current[1]";
    }
    if ( $d eq q{U} ) {
        $current[0] = get_previous( $current[0], $walls{col}{ $current[1] }, $l );
        #warn "--- $current[0]";
    }
    if ( $d eq q{D} ) {
        $current[0] = get_next( $current[0], $walls{col}{ $current[1] }, $l, $h );
        #warn "--- $current[0]";
    }

    say join q{ }, @current;
}


exit;

sub get_previous {
    my $point = shift;
    my $walls_ref = shift;
    my $length = shift;

    #warn "### get_previous";
    #warn Dumper $walls_ref;

    if ( !$walls_ref || $walls_ref->[0] > $point ) {
        return max( $point - $length, 1 );
    }

    if ( $walls_ref && $point > $walls_ref->[-1] ) {
        return max( $point - $length, 1, $walls_ref->[-1] );
    }

    #warn "--- binary search";

    my $ac = $#{ $walls_ref };
    my $wa = 0;

    while ( $ac - $wa > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );

        if ( $walls_ref->[ $wj ] > $point ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    #warn "--- ac, wa: ($ac, $wa)";

    return max( $point - $length, $walls_ref->[ $ac ] + 1, 1 );
}

sub get_next {
    my $point = shift;
    my $walls_ref = shift;
    my $length = shift;
    my $max = shift;

    #warn "### get_next";
    #warn Dumper $walls_ref;

    if ( !$walls_ref || $walls_ref->[-1] < $point ) {
        return min( $point + $length, $max );
    }

    if ( $walls_ref && $point < $walls_ref->[0] ) {
        return min( $point + $length, $walls_ref->[0], $max );
    }

    #warn "--- binary search";

    my $ac = 0;
    my $wa = $#{ $walls_ref };

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );

        if ( $walls_ref->[ $wj ] < $point ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    return min( $point + $length, $walls_ref->[ $wa ] - 1, $max );
}
