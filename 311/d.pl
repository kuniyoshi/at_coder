#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

my @can_visits = map { [ ( 0 ) x $m ] } 1 .. $n;
my %did_start;

my @directions = (
    [ 0, 1 ],
    [ 1, 0 ],
    [ 0, -1 ],
    [ -1, 0 ],
);

my @queue = ( [ 1, 1 ] );

while ( @queue ) {
    my( $y, $x ) = @{ shift @queue };

    next
        if $did_start{ $y }{ $x }++;

    $can_visits[ $y ][ $x ] = 1;

    for my $d_ref ( @directions ) {
        my( $dy, $dx ) = @{ $d_ref };

        my $length = 0;

        while ( can_be( $y + $dy * ( $length + 1 ), $x + $dx * ( $length + 1 ) ) ) {
            $length++;
            $can_visits[ $y + $dy * $length ][ $x + $dx * $length ] = 1;
        }

        next
            if $did_start{ $y + $dy * $length }{ $x + $dx * $length };

        push @queue, [ $y + $dy * $length, $x + $dx * $length ];
    }
}

#print map { join( q{}, @{ $_ } ), "\n" } @can_visits;

say scalar grep { $_ } map { @{ $_ } } @can_visits;

exit;

sub can_be {
    my( $y, $x ) = @_;
    my $can = $y >= 0 && $y < $n && $x >= 0 && $x < $m;
    return $can && $s[ $y ][ $x ] eq q{.};
}
