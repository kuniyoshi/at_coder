#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

for my $ref ( @queries ) {
    printf "%.16f %.16f %.16f\n", solve( @{ $ref } );
}

exit;

sub solve {
    my( $x, $y, $z, $t ) = @_;
    my @a = (
        [ 1 - $x, $y, 0 ],
        [ 0, 1 - $y, $z ],
        [ $x, 0, 1 - $z ],
    );
    my $ref = power( \@a, $t );
    my $a = sum( @{ $ref->[0] } );
    my $b = sum( @{ $ref->[1] } );
    my $c = sum( @{ $ref->[2] } );
    return $a, $b, $c;
}

sub power {
    my $matrix_ref = shift;
    my $t = shift;
    my @matrixes = ( $matrix_ref );
    my @bits = bits( $t );
    my $acc = $matrix_ref;
    for my $i ( 1 .. $#bits ) {
        $acc = multiply( $acc, $acc );
        push @matrixes, $acc;
    }
    my $result = [
        [ 1, 0, 0 ],
        [ 0, 1, 0 ],
        [ 0, 0, 1 ],
    ];
    for my $i ( 0 .. $#bits ) {
        next
            unless $bits[ $i ];
        $result = multiply( $result, $matrixes[ $i ] );
    }
    return $result;
}

sub multiply {
    my $a = shift;
    my $b = shift;

    my $c = [
        [
            zip_reduce_by_multiply( $a->[0], [ map { $b->[ $_ ][0] } 0 .. 2 ] ),
            zip_reduce_by_multiply( $a->[0], [ map { $b->[ $_ ][1] } 0 .. 2 ] ),
            zip_reduce_by_multiply( $a->[0], [ map { $b->[ $_ ][2] } 0 .. 2 ] ),
        ],
        [
            zip_reduce_by_multiply( $a->[1], [ map { $b->[ $_ ][0] } 0 .. 2 ] ),
            zip_reduce_by_multiply( $a->[1], [ map { $b->[ $_ ][1] } 0 .. 2 ] ),
            zip_reduce_by_multiply( $a->[1], [ map { $b->[ $_ ][2] } 0 .. 2 ] ),
        ],
        [
            zip_reduce_by_multiply( $a->[2], [ map { $b->[ $_ ][0] } 0 .. 2 ] ),
            zip_reduce_by_multiply( $a->[2], [ map { $b->[ $_ ][1] } 0 .. 2 ] ),
            zip_reduce_by_multiply( $a->[2], [ map { $b->[ $_ ][2] } 0 .. 2 ] ),
        ],
    ];

    return $c;
}

sub zip_reduce_by_multiply {
    my $a = shift;
    my $b = shift;
    my $total = 0;
    for my $i ( 0 .. $#{ $a } ) {
        $total += $a->[ $i ] * $b->[ $i ];
    }
    return $total;
}

sub bits {
    my $t = shift;
    return reverse split m{}, sprintf "%b", $t;
}
