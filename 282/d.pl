#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;

my %links;
for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    push @{ $links{ $u } }, $v;
    push @{ $links{ $v } }, $u;
}

my @colors;
$colors[1] = q{A};

#dfs( 1, \my %visited );

my %visited;
my @queue = ( [ 1, q{A} ] );

while ( @queue ) {
    my( $u, $color ) = @{ shift @queue };
    next
        if $visited{ $u }++;
    $colors[ $u ] = $color;
    my $other = $color eq q{A} ? q{B} : q{A};
    push @queue, map { [ $_, $other ] } grep { !$visited{ $_ } } @{ $links{ $u } };
}

for my $i ( 1 .. $n ) {
    if ( grep { $colors[ $_ ] eq $colors[ $i ] } @{ $links{ $i } } ) {
        say 0;
        exit;
    }
}

my %count;

for my $i ( 1 .. $n ) {
    if ( !defined $colors[ $i ] ) {
        say 0;
        exit;
    }

    $count{ $colors[ $i ] }++;
}

my $total = 0;

for my $i ( 1 .. $n ) {
    my $other_color = $colors[ $i ] eq q{A} ? q{B} : q{A};
    my $alreadies = grep { $colors[ $_ ] eq $other_color } @{ $links{ $i } };
    $total += $count{ $other_color } - $alreadies;
}

say $total / 2;

exit;

sub dfs {
    my $current = shift;
    my $visited_ref = shift;

    return
        if $visited_ref->{ $current }++;

    die "no color found at $current"
        if !defined $colors[ $current ];

    my $other = $colors[ $current ] eq q{A} ? q{B} : q{A};

    for my $next ( grep { !$visited_ref->{ $_ } } @{ $links{ $current } } ) {
        $colors[ $next ] = $other;
        dfs( $next, $visited_ref );
    }

    return;
}
