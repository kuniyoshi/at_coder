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

my %graph;

for my $ab_ref ( @ab ) {
    my( $a, $b ) = @{ $ab_ref };
    push @{ $graph{ $a } }, $b;
    push @{ $graph{ $b } }, $a;
}

my %done;

for my $i ( 1 .. $n ) {
    next
        if $done{ $i }++;
    next
        if !$graph{ $i };

    my @s;
    my $neighbors_ref = delete $graph{ $i };

    if ( @{ $neighbors_ref } > 2 ) {
        say "No";
        exit;
    }
    elsif ( @{ $neighbors_ref } == 2 ) {
        @s = ( $neighbors_ref->[0], $i, $neighbors_ref->[1] );
    }
    else {
        die "somehow"
            if @{ $neighbors_ref } != 1;

        @s = ( $i, $neighbors_ref->[0] );
    }

    my %is_in;
    $is_in{ $_ }++
        for @s;

    while ( $graph{ $s[0] } ) {
        my $ref = delete $graph{ $s[0] };
        if ( @{ $ref } > 2 ) {
            say "No";
            exit;
        }
        elsif ( @{ $ref } == 2 ) {
            if ( $ref->[0] != $s[1] && $ref->[1] != $s[1] ) {
                say "No";
                exit;
            }
            unshift @s, ( $ref->[0] == $s[1] ? $ref->[1] : $ref->[0] );
            if ( $is_in{ $s[0] }++ ) {
                say "No";
                exit;
            }
            $done{ $ref->[0] }++;
            $done{ $ref->[1] }++;
        }
        else {
            die "somehow"
                if @{ $ref } != 1;
            if ( $ref->[0] != $s[1] ) {
                unshift @s, $ref->[0];
                if ( $is_in{ $s[0] }++ ) {
                    say "No";
                    exit;
                }
                $done{ $ref->[0] }++;
            }
        }
    }

    while ( $graph{ $s[-1] } ) {
        my $ref = delete $graph{ $s[-1] };
        if ( @{ $ref } > 2 ) {
            say "No";
            exit;
        }
        elsif ( @{ $ref } == 2 ) {
            if ( $ref->[0] != $s[-2] && $ref->[1] != $s[-2] ) {
                say "No";
                exit;
            }
            push @s, ( $ref->[0] == $s[-2] ? $ref->[1] : $ref->[0] );
            if ( $is_in{ $s[-1] }++ ) {
                say "No";
                exit;
            }
            $done{ $ref->[0] }++;
            $done{ $ref->[1] }++;
        }
        else {
            die "somehow"
                if @{ $ref } != 1;
            if ( $ref->[0] != $s[-2] ) {
                push @s, $ref->[0];
                if ( $is_in{ $s[-1] }++ ) {
                    say "No";
                    exit;
                }
                $done{ $ref->[0] }++;
            }
        }
    }
}

say "Yes";

exit;
