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
        my $length = $direction eq "row" ? $w : $h;
        $walls{ "reverse_$direction" }{ $value } = [ sort { $a <=> $b } map { $length - $_ + 1 } @{ $walls{ $direction }{ $value } } ];
    }
}

my @current = ( $rs, $cs );

for my $ref ( @queries ) {
    my( $d, $l ) = @{ $ref };
    #warn "### ($d, $l)";

    if ( $d eq q{L} ) {
        my $wall_point = binary_search( r( $current[1], $w ), $walls{reverse_row}{ $current[0] } ) // $w + 1;
        $current[1] = r( min( r( $current[1], $w ) + $l, $wall_point - 1 ), $w );
        #warn "--- $current[1]";
    }
    if ( $d eq q{R} ) {
        my $wall_point = binary_search( $current[1], $walls{row}{ $current[0] } ) // $w + 1;
        $current[1] = min( $current[1] + $l, $wall_point - 1 );
        #warn "--- $current[1]";
    }
    if ( $d eq q{U} ) {
        my $wall_point = binary_search( r( $current[0], $h ), $walls{reverse_col}{ $current[1] } ) // $h + 1;
        $current[0] = r( min( r( $current[0], $h ) + $l, $wall_point - 1 ), $h );
        #warn "--- $current[0]";
    }
    if ( $d eq q{D} ) {
        my $wall_point = binary_search( $current[0], $walls{col}{ $current[1] } ) // $h + 1;
        $current[0] = min( $current[0] + $l, $wall_point - 1 );
        #warn "--- $current[0]";
    }

    say join q{ }, @current;
}


exit;

sub r {
    my $value = shift;
    my $max = shift;
    return $max - $value + 1;
}

sub binary_search {
    my $value = shift;
    my $ref = shift;

    return
        unless $ref;

    return $ref->[0]
        if $ref->[0] > $value;

    return
        if $ref->[-1] < $value;

    my $ac = $#{ $ref };
    my $wa = 0;

    while ( $ac - $wa > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );

        if ( $ref->[ $wj ] > $value ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    return $ref->[ $ac ];
}
