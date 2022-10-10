#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util ( );

my( $n, $m, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;
my @paths = do { chomp( my $l = <> ); split m{\s}, $l };

my @costs = ( 0 );

for my $path ( @paths ) {
    my( $u, $v, $cost ) = @{ $edges[ $path - 1 ] };
    $u--;
    $v--;
    $costs[ $v ] = !defined $costs[ $u ] ? $costs[ $v ] : min2( $costs[ $u ] + $cost, $costs[ $v ] );
}

say $costs[ $n - 1 ] // -1;

exit;

sub min2 {
    my $new = shift;
    my $current = shift;
    die "new should be defined"
        unless defined $new;
    return $new
        if !defined $current;
    return List::Util::min( $new, $current );
}
