#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util ( );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @numbers = sort { $b <=> $a } @a;
#warn "### numbers";
#warn Dumper \@numbers;

my @odds = grep { $_ % 2 } @numbers;
#warn "### odds";
#warn Dumper \@odds;
my @evens = grep { !( $_ % 2 ) } @numbers;
#warn "### evens";
#warn Dumper \@evens;

my $max = max( calc( @odds[ 0, 1 ] ), calc( @evens[ 0, 1 ] ) );
die "could not get max"
    if !$max;

say $max;

exit;

sub calc {
    my $a = shift;
    my $b = shift;
    return
        if !defined $a || !defined $b;
    die "sum is not even"
        if ( ( $a + $b ) % 2 );
    return $a + $b;
}

sub max {
    my $a = shift;
    my $b = shift;
    return -1
        if !defined $a && !defined $b;
    return $a
        if !defined $b;
    return $b
        if !defined $a;
    return List::Util::max( $a, $b );
}
