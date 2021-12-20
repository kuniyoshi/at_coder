#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @ab = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $m;
my @cd = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $m;

my @edges_ab;

for my $ref ( @ab ) {
    my( $a, $b ) = @{ $ref };
    $edges_ab[ $a ][ $b ] = 1;
    $edges_ab[ $b ][ $a ] = 1;
}

my @edges_cd;

for my $ref ( @cd ) {
    my( $c, $d ) = @{ $ref };
    $edges_cd[ $c ][ $d ] = 1;
    $edges_cd[ $d ][ $c ] = 1;
}

my @patterns;
list_permutations( [ ], [ 1 .. $n ], \@patterns );

LOOP_PATTERNS:
for my $pattern_ref ( @patterns ) {
    for ( my $i = 0; $i < $n; ++$i ) {
        for ( my $j = 0; $j < $n; ++$j ) {
            my $v = @{ $pattern_ref }[ $i ];
            my $w = @{ $pattern_ref }[ $j ];
            my $ab = $edges_ab[ $i + 1 ][ $j + 1 ] //= 0;
            my $cd = $edges_cd[ $v ][ $w ] //= 0;
            next LOOP_PATTERNS
                if $ab != $cd;
        }
    }

    say "Yes";
    exit;
}

say "No";

exit;

sub list_permutations {
    my( $buffer_ref, $queue_ref, $results_ref ) = @_;

    if ( !@{ $queue_ref } ) {
        push @{ $results_ref }, [ @{ $buffer_ref } ];
        return;
    }

    for ( my $i = 0; $i < @{ $queue_ref }; ++$i ) {
        my @buffer = ( @{ $buffer_ref }, $queue_ref->[ $i ] );
        my @queue = ( @{ $queue_ref }[ 0 .. $i - 1, $i + 1 .. $#{ $queue_ref } ] );
        list_permutations( \@buffer, \@queue, $results_ref );
    }
}
