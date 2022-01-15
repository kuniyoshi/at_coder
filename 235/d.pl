#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $a, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp;
$dp[ $n ] = 0;
say dfs( $n, 0, length( $n ) - 1 ) // -1;

exit;

sub dfs {
    my( $number, $count, $remain ) = @_;
    say "( $number, $count, $remain )";

    return
        if $dp{ $number }++;

    return $count
        if $number == 1;

    my $op_a = ( ( $number % $a ) == 0 ) ? dfs( $number / $a, $count + 1, length( $number ) - 1 ) : undef;

    my @digits = split m{}, $number;
    my $op_b = ( $remain && @digits > 1 && ( $number % 10 ) )#&& $digits[0] > $digits[-1] )
        ? dfs( join( q{}, @digits[ -1, 0 .. ( $#digits - 1 ) ] ), $count + 1, $remain - 1 )
        : undef;

    return min( $op_a, $op_b )
        if defined $op_a && defined $op_b;

    return $op_a
        if defined $op_a;

    return $op_b
        if defined $op_b;

    return;
}
