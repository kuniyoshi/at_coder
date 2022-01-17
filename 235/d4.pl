#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $a, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };

my %visited;
my $answer = bfs( 1, 0, [ ] );

say $answer // -1;

exit;

sub bfs {
    my $value = shift;
    my $count = shift;
    my $queue_ref = shift;

    return $count
        if $value == $n;

    return
        if $visited{ $value }++;

    my @nexts;

    push @nexts, $value * $a
        if length( $value * $a ) <= length ( $n );

    my @digits = split m{}, $value;

    push @nexts, join q{}, @digits[ -1, 0 .. ( $#digits - 1 ) ]
        if @digits > 1 && $digits[-1];

    my @counts = grep { defined }
                 map { bfs( $_, $count + 1 ) }
                 @nexts;

    return
        unless @counts;

    return min( @counts );
}
