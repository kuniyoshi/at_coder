#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w, $n ) = split m{\s}, <>;
chomp( my @cards = <> );

my %row = ( );
my %col = ( );

for my $card ( @cards ) {
    my( $r, $c ) = split m{\s}, $card;
    $row{ $r }++;
    $col{ $c }++;
}

my @rows = sort { $a <=> $b } keys %row;
my @cols = sort { $a <=> $b } keys %col;

for my $card ( @cards ) {
    my( $r, $c ) = split m{\s}, $card;

    my $r_index = find_index( \@rows, $r );
    die "Could not found index of [$r] from row"
        if !defined $r_index;

    my $c_index = find_index( \@cols, $c );
    die "Could not found index of [$c] from col"
        if !defined $c_index;

    my $r_number = $r_index + 1;
    my $c_number = $c_index + 1;

    say "$r_number $c_number";
}

exit;

sub find_index {
    my $nums_ref = shift;
    my $target = shift;

    my $left = 0;
    my $right = $#{ $nums_ref };
    my $center = $left + int( ( $right - $left ) / 2 );

    while ( $nums_ref->[ $center ] != $target && $right > $left ) {
        my $c = $nums_ref->[ $center ];

        if ( $c < $target ) {
            $left = $center + 1;
            $center = $left + int( ( $right - $left ) / 2 );
            next;
        }

        if ( $c > $target ) {
            $right = $center - 1;
            $center = $left + int( ( $right - $left ) / 2 );
            next;
        }
    }

    if ( $nums_ref->[ $center ] == $target ) {
        return $center;
    }

    return;
}
