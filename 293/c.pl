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

say dfs( [ 0, 0 ], ( ) );

exit;

sub dfs {
    my $coord_ref = shift;
    my %owned = @_;
    my( $i, $j ) = @{ $coord_ref };
    return 0
        if $owned{ $a[ $i ][ $j ] }++;
    return 1
        if $i == $h - 1 && $j == $w - 1;
    my $left = $j != $w - 1 ? dfs( [ $i, $j + 1 ], %owned ) : 0;
    my $right = $i != $h - 1 ? dfs( [ $i + 1, $j ], %owned ) : 0;
    return $left + $right;
}
