#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $m2 = $m * $m;

my @candidates = map { [ $_ * $_, $_ ] } 0 .. $m;
my @pairs;

for my $i ( 0 .. $#candidates ) {
    for my $j ( 0 .. $i ) {
        my $a2 = $candidates[ $i ][0];
        my $a = $candidates[ $i ][1];
        my $b2 = $candidates[ $j ][0];
        my $b = $candidates[ $j ][1];
        push @pairs, [ $a, $b ]
            if $a2 + $b2 == $m2;
    }
}

my @dp;

for my $i ( 0 .. $n - 1 ) {
    for my $j ( 0 .. $n - 1 ) {
        $dp[ $i ][ $j ] = -1;
    }
}
$dp[0][0] = 0;

#die "too many candidates"
#    if @pairs > 1;

#if ( @pairs != 1 ) {
#    output( );
#    exit;
#}

my( $di, $dj ) = @{ $pairs[0] };
my @queue;
push @queue, [ [ $di, $dj ], 0 ]
    if $di < $n && $dj < $n;
push @queue, [ [ $dj, $di ], 0 ]
    if $di < $n && $dj < $n;

while ( @queue ) {
    my $ref = shift @queue;
    my( $next, $cost ) = @{ $ref };
    my( $ni, $nj ) = @{ $next };
    next
        if $dp[ $ni ][ $nj ] != -1;
    $dp[ $ni ][ $nj ] = $cost + 1;

    conditional_push( \@queue, $ni + $di, $nj + $dj, $cost + 1 );
    conditional_push( \@queue, $ni - $di, $nj + $dj, $cost + 1 );
    conditional_push( \@queue, $ni + $di, $nj - $dj, $cost + 1 );
    conditional_push( \@queue, $ni - $di, $nj - $dj, $cost + 1 );
    conditional_push( \@queue, $ni + $dj, $nj + $di, $cost + 1 );
    conditional_push( \@queue, $ni - $dj, $nj + $di, $cost + 1 );
    conditional_push( \@queue, $ni + $dj, $nj - $di, $cost + 1 );
    conditional_push( \@queue, $ni - $dj, $nj - $di, $cost + 1 );
}

output( );

exit;

sub conditional_push {
    my $ref = shift;
    my $i = shift;
    my $j = shift;
    my $cost = shift;
    return
        if $i >= $n || $j >= $n || $i < 0 || $j < 0;
    return
        if $dp[ $i ][ $j ] != -1;
    push @{ $ref }, [ [ $i, $j ], $cost ];
}

sub output {
    say join q{ }, @{ $_ }
        for @dp;
}
