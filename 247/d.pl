#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my @queue;

for my $q_ref ( @queries ) {
    my $code = shift @{ $q_ref };

    if ( $code == 1 ) {
        push @queue, $q_ref;
    }
    elsif ( $code == 2 ) {
        my $c = $q_ref->[0];
        my $remain = $c;
        my $acc = 0;

        while ( $remain ) {
            die "no items in queue"
                unless @queue;
            my $take = min( $remain, $queue[0][1] );
            $remain -= $take;
            die "remain goes negative somehow"
                if $remain < 0;
            $acc += $queue[0][0] * $take;
            $queue[0][1] -= $take;
            die "unknown: ($queue[0][1], $remain)"
                if $queue[0][1] != 0 && $remain > 0;
            shift @queue
                if $queue[0][1] == 0;
        }

        say $acc;
    }
    else {
        die "Invalid query found: ", Dumper $q_ref;
    }
}

exit;
