#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $x, $y ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n - 1;

$x--;
$y--;

my %links_of;

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    $u--;
    $v--;
    push @{ $links_of{ $u } }, $v;
    push @{ $links_of{ $v } }, $u;
}

my @vertexes = ( $x );
dfs( $x, undef, \@vertexes );

say join q{ }, map { $_ + 1 } @vertexes;

exit;

sub dfs {
    my $current = shift;
    my $previous = shift;
    my $vertexes_ref = shift;

    if ( $current == $y ) {
        return 1;
    }

    my @neighbors = @{ $links_of{ $current } };

    if ( @neighbors == 1 && defined $previous && $neighbors[0] == $previous ) {
        pop @{ $vertexes_ref };
        return;
    }

    for my $u ( @{ $links_of{ $current } } ) {
        next
            if defined $previous && $u == $previous;
        push @{ $vertexes_ref }, $u;
        if ( dfs( $u, $current, $vertexes_ref ) ) {
            return 1;
        }
    }

    pop @{ $vertexes_ref };
    return;
}
