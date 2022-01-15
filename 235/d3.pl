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
$dp[1] = 0;
my %used;

my @queue = ( [ $a, 1 ] );

while ( @queue ) {
    my( $next, $count ) = @{ shift @queue };
    $dp[ $next ] = min( ( $dp[ $next ] // $count ), $count );

    if ( length( $next * $a ) <= length( $n ) ) {
        push @queue, [ $next * $a, $count + 1 ];
    }

    my @digits = split m{}, $next;

    if ( @digits > 1 && $digits[-1] ) {
        for ( my $i = 0; $i < ( @digits - 1 ); ++$i ) {
            last
                unless $digits[-1];
            my $last = pop @digits;
            unshift @digits, $last;
            my $value = join( q{}, @digits );
            next
                if $used{ $value }++;
            push @queue, [ $value, $count + 1 + $i ];
        }
    }
}

say $dp[ $n ] // -1;

exit;

