#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = sort { $a <=> $b } do { chomp( my $l = <> ); split m{\s}, $l };
my @b = sort { $a <=> $b } do { chomp( my $l = <> ); split m{\s}, $l };

my @events;

for my $a ( @a ) {
    push @events, [ $a, 0 ];
}

for my $b ( @b ) {
    push @events, [ $b, 1 ];
}

@events = sort { $a->[0] <=> $b->[0] } @events;

my $c = $m;

for my $e ( @events ) {

}

exit;
