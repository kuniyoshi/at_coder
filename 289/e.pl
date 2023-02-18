#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $t = <> );

while ( $t-- ) {
    say solve( );
}

exit;

sub solve {
    my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
    my @c = do { chomp( my $l = <> ); split m{\s}, $l };
    my @edges = map { chomp; [ split m{\s} ] }
                map { scalar <> }
                1 .. $m;

    unshift @c, 0;

    my %links;

    for my $ref ( @edges ) {
        my( $u, $v ) = @{ $ref };
        push @{ $links{ $u } }, $v;
        push @{ $links{ $v } }, $u;
    }

    my @queue = ( [ 1, $n, 0 ] );
    my %visited;

    while ( @queue ) {
        my( $t, $a, $cost ) = @{ shift @queue };

        return $cost
            if $t == $n && $a == 1;
        next
            if $visited{ $t }{ $a }++;

        for my $tn ( @{ $links{ $t } } ) {
            for my $an ( @{ $links{ $a } } ) {
                next
                    if $visited{ $tn }{ $an };
                next
                    if $c[ $an ] == $c[ $tn ];

                push @queue, [ $tn, $an, $cost + 1 ];
            }
        }
    }

    return -1;
}
