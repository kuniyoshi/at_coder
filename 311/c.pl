#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %link;

for my $i ( 0 .. $#a ) {
    push @{ $link{ $i } }, $a[ $i ] - 1;
}

my %global_visited;

for my $i ( 0 .. $n - 1 ) {
    next
        if $global_visited{ $i }++;
    my $ref = dfs( [ ], $i, { }, 0 );
    #warn Dumper $ref;
    next
        unless $ref->[0];

    say scalar @{ $ref->[1] };
    say join q{ }, map { $_ + 1 } @{ $ref->[1] };
    exit;
}


exit;

sub dfs {
    my $paths_ref = shift;
    my $u = shift;
    my $visited_at = shift;
    my $when = shift;

    $global_visited{ $u }++;

    if ( exists $visited_at->{ $u } ) {
        #warn Dumper $paths_ref;
        #warn "[$visited_at->{ $u }, $when]";
        my @paths = @{ $paths_ref }[ $visited_at->{ $u } .. ( $when - 1 ) ];
        return [ 1, \@paths ];
    }

    $visited_at->{ $u } = $when;

    push @{ $paths_ref }, $u;

    for my $v ( @{ $link{ $u } } ) {
        #warn "\$v: $v";
        my $r = dfs( $paths_ref, $v, $visited_at, $when + 1 );
        if ( $r->[0] ) {
            return $r;
        }
    }

    pop @{ $paths_ref };

    return [ 0 ];
}
