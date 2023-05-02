#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $t ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @c = do { chomp( my $l = <> ); split m{\s}, $l };
my @r = do { chomp( my $l = <> ); split m{\s}, $l };

my $winner = 0;

for my $i ( 1 .. $n - 1 ) {
    $winner = winner( $i, $winner );
}

say $winner + 1;

exit;

sub winner {
    my $i = shift;
    my $j = shift;

    if ( $c[ $i ] != $c[ $winner ]) {
        if ( $c[ $i ] == $t || $c[ $j ] == $t ) {
            return $c[ $i ] == $t ? $i : $j;
        }
        return $c[ $i ] == $c[0] ? $i : $j;
    }

    return $r[ $i ] > $r[ $j ] ? $i : $j;
}
