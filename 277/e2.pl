#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;
my @s = do { chomp( my $l = <> ); split m{\s}, $l };

my %links;

for my $ref ( @edges ) {
    my( $u, $v, $s ) = @{ $ref };
    $u--;
    $v--;
    if ( $s ) {
        $u += $n;
        $v += $n;
    }
    push @{ $links{ $u } }, [ $v, 1 ];
    push @{ $links{ $v } }, [ $u, 1 ];
}

push @s, $n;

for my $s ( @s ) {
    $s--;
    push @{ $links{ $s } }, [ $s + $n, 0 ];
    push @{ $links{ $s + $n } }, [ $s, 0 ];
}

#die Dumper \%links;

my @queue = ( [ 0, $n ] );
my %cost = ( $n => 0 );

while ( @queue ) {
    my( $cost, $u ) = @{ shift @queue };
    next
        if exists $cost{ $u } && $cost != $cost{ $u };

    for my $ref ( @{ $links{ $u } } ) {
        my( $v, $c ) = @{ $ref };
        next
            if exists $cost{ $v } && $cost + $c >= $cost{ $v };
        $cost{ $v } = $cost + $c;
        if ( $c ) {
            push @queue, [ $cost + $c, $v ];
        }
        else {
            unshift @queue, [ $cost, $v ];
        }
    }
}

say $cost{ 2 * $n - 1 } // -1;

exit;

