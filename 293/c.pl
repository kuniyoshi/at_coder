#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $h;

say dfs( [ 0, 0 ], { } );

exit;

sub dfs {
    my $coord_ref = shift;
    my $owned_ref = shift;
    my( $i, $j ) = @{ $coord_ref };

    if ( $owned_ref->{ $a[ $i ][ $j ] } ) {
        return 0;
    }

    $owned_ref->{ $a[ $i ][ $j ] }++;

    if ( $i == $h - 1 && $j == $w - 1 ) {
        delete $owned_ref->{ $a[ $i ][ $j ] };
        return 1;
    }

    my $left = $j != $w - 1 ? dfs( [ $i, $j + 1 ], $owned_ref ) : 0;
    my $right = $i != $h - 1 ? dfs( [ $i + 1, $j ], $owned_ref ) : 0;

    delete $owned_ref->{ $a[ $i ][ $j ] };

    return $left + $right;
}
