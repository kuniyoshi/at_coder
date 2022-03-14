#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @c = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $n;
my @s = do { chomp( my $l = <> ); split m{}, $l };

my @coords = sort { $a->[0] <=> $b->[0] }
             map  { [ @{ $c[ $_ ] }, $s[ $_ ] ] }
             0 .. ( $n - 1 );

my %align;

for my $coord_ref ( @coords ) {
    my( $x, $y, $align ) = @{ $coord_ref };

    if ( $align eq q{L} && $align{ $y } ) {
        say "Yes";
        exit;
    }

    $align{ $y }++
        if $align eq q{R};
}

say "No";

exit;
