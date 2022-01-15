#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $a, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };

say dfs( 1, 0 );

exit;

sub dfs {
    my $number = shift;
    my $count = shift;
    return $count
        if $number == $n;

    return
        if length( $number ) > length( $n );

    my $can_a = ( $number % $a ) == 0;
    my @digits = split m{}, $number;
    my $can_b = @digits > 1;

    if ( $can_a && $can_b ) {
        my $x = dfs( $number / $a, $count + 1 );
        my $y = dfs( join( q{}, @digits[ -1, 0 .. ( $#digits - 1 ) ] ), $count + 1 );
        if ( defined $x && defined $y ) {
            return min( $x, $y );
        }
        return $x // $y;
    }
    return dfs( 
}

while ( length( $number ) <= length( $n ) ) {

}
while ( !defined $dp[1] ) {
    die
        if !defined $dp[ $number ];
    $dp[ $number * $a ] = min( $dp[ $number ] + 1, $dp[ $number * $a ] // ( $dp[ $number ] + 1 ) );

    $can_a = $number < $n;

    my @digits = split m{}, $number;
    my $x = join q{}, 
    min( grep { defined } ( $dp[ $number ] + 1,  ) )
        ? $dp[ 
    min( $dp[ $number * $a ] // 2e18, $dp[ $number ] + 1
    my $count = $dp[ $number ] // 0;

}

say $dp[ $n ] // -1;

exit;
