#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $t, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @pairs = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;

my %bad;

for my $ref ( @pairs ) {
    my( $a, $b ) = @{ $ref };
    $bad{ $a }{ $b }++;
    $bad{ $b }{ $a }++;
}

say dfs( [ map { { } } 1 .. $t ], 1 ) / permutation( $t );

exit;

sub permutation {
    my $n = shift;
    my $acc = 1;
    while ( $n ) {
        $acc *= $n;
        $n--;
    }
    return $acc;
}

sub dfs {
    my $team_ref = shift;
    my $who = shift;

    return $t == grep { %{ $_ } } @{ $team_ref }
        if $who > $n;

    my $count = 0;

    for my $i ( 0 .. $t - 1 ) {
        next
            if grep { $bad{ $who }{ $_ } } keys %{ $team_ref->[ $i ] };
        $team_ref->[ $i ]{ $who }++;
        $count += dfs( $team_ref, $who + 1 );
        delete $team_ref->[ $i ]{ $who };
    }

    return $count;
}
