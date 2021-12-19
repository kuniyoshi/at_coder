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

my %ab_edges;
$ab_edges{ $_ } = [ ]
    for 1 .. $n;

for my $ref ( @ab ) {
    my( $a, $b ) = @{ $ref };
    push @{ $ab_edges{ $a } }, $b;
    push @{ $ab_edges{ $b } }, $a;
}

my %cd_edges;
$cd_edges{ $_ } = [ ]
    for 1 .. $n;

for my $ref ( @cd ) {
    my( $c, $d ) = @{ $ref };
    push @{ $cd_edges{ $c } }, $d;
    push @{ $cd_edges{ $d } }, $c;
}

my @all = ( );
list_patterns( [ ], [ 1 .. $n ], \@all );

PATTERN_LOOP:
for my $pattern_ref ( @all ) {
    my @v = @{ $pattern_ref };

    #    for ( my $i = 0; $i < @v; ++$i ) {
    #        my $v = $v[ $i ];
    #        my $w = $i + 1;
    #        my $x = join q{:}, sort { $a <=> $b } @{ $ab_edges{ $w } };
    #        my $y = join q{:}, sort { $a <=> $b } map { $v[ $_ - 1 ] } @{ $cd_edges{ $v } };
    #        next PATTERN_LOOP
    #            if $x ne $y;
    #    }

    for ( my $i = 1; $i <= $n; ++$i ) {
        for ( my $j = 1; $j < $i; ++$j ) {
            my $is_t = grep { $_ == $j } @{ $ab_edges{ $i } };
            my $is_a = grep { $v[ $_ - 1 ] == $j } @{ $cd_edges{ $v[ $i - 1 ] } };
            next PATTERN_LOOP
                if $is_t != $is_a;
        }
    }

    say "Yes";
    exit;
}

say "No";

exit;

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
