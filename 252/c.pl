#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $n = <> );
my @s = map { do { chomp( my $l = <> ); [ split m{}, $l ] } }
        1 .. $n;

my $min = min( map { get_time( $_ ) } 0 .. 9 );

say $min;

exit;

sub get_time {
    my $target = shift;
    my @reels = sort { $a <=> $b }
                map { index_of( $target, $s[ $_ ] ) } 0 .. $#s;
    my $total = 0;

    while ( @reels ) {
        my $next = shift @reels;
        my $elapsed = $next - $total;
        $total += $elapsed;

        while ( @reels && $reels[0] == $next ) {
            my $to_back = shift @reels;
            push @reels, $to_back + 10;
        }
    }

    return $total;
}

sub index_of {
    my $target = shift;
    my $ref = shift;

    for my $i ( 0 .. $#{ $ref } ) {
        return $i
            if $ref->[ $i ] == $target;
    }

    die "Could not found: $target in ", join q{, }, @{ $ref };
}
