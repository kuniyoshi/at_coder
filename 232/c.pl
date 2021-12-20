#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { my $l = <>; split m{\s}, $l };
my @ab = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $m;
my @cd = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $m;

my %ab_edges = make_edges( @ab );
my %cd_edges = make_edges( @cd );

my @all;
list_patterns( [ ], [ 1 .. $n ], \@all );

PATTERN_LOOP:
for my $pattern_ref ( @all ) {
    my @v = @{ $pattern_ref };

    for ( my $i = 0; $i < $n; ++$i ) {
        for ( my $j = 0; $j < $n; ++$j ) {
            my $is_t = grep { $_ == ( $j + 1 ) } @{ $ab_edges{ $i + 1 } };
            my $is_a = grep { $_ == $v[ $j ] } @{ $cd_edges{ $v[ $i ] } };
            next PATTERN_LOOP
                if $is_t != $is_a;
        }
    }

    say "Yes";
    exit;
}

say "No";

exit;

sub make_edges {
    my @edges = @_;

    my %edge;
    $edge{ $_ } = [ ]
        for 1 .. $n;
    for my $ref ( @edges ) {
        my( $from, $to ) = @{ $ref };
        push @{ $edge{ $from } }, $to;
        push @{ $edge{ $to } }, $from;
    }

    return %edge;
}

sub list_patterns {
    my $buffer_ref = shift;
    my $queue_ref = shift;
    my $all_ref = shift;

    if ( !@{ $queue_ref } ) {
        push @{ $all_ref }, [ @{ $buffer_ref } ];
        return;
    }

    for ( my $i = 0; $i < @{ $queue_ref }; ++$i ) {
        my @buffer = @{ $buffer_ref };
        push @buffer, $queue_ref->[ $i ];
        list_patterns( \@buffer, [ @{ $queue_ref }[ 0 .. $i - 1, $i + 1 .. $#{ $queue_ref } ] ], $all_ref );
    }
}
