#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @digits = sort { $b <=> $a } split m{}, $n;

my @l = ( );
my @r = ( );

my $next = 0;

while ( @digits ) {
    my $digit = shift @digits;
    my $selection = $next++ % 4;

    if ( $selection == 0 || $selection == 3 ) {
        push @l, $digit;
    }
    else {
        push @r, $digit;
    }
}

my $l = join q{}, @l;
my $r = join q{}, @r;

say $l * $r;

exit;
