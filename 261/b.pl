#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

say is_correct( ) ? "correct" : "incorrect";

exit;

sub is_correct {
    for my $i ( 0 .. $n - 1 ) {
        for my $j ( 0 .. $i - 1 ) {
            if ( $a[ $i ][ $j ] eq q{W} && $a[ $j ][ $i ] ne q{L} ) {
                return;
            }
            if ( $a[ $i ][ $j ] eq q{L} && $a[ $j ][ $i ] ne q{W} ) {
                return;
            }
            if ( $a[ $i ][ $j ] eq q{D} && $a[ $j ][ $i ] ne q{D} ) {
                return;
            }
        }
    }

    return 1;
}
