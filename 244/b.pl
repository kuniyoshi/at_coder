#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $t = <> );

my @operations = split m{}, $t;

my $position = [ 0, 0 ];

my @directions = (
    [ 1, 0 ],
    [ 0, -1 ],
    [ -1, 0 ],
    [ 0, 1 ],
);
my $handle = 0;

for my $operation ( @operations ) {
    if ( $operation eq q{S} ) {
        $position->[0] = $position->[0] + $directions[ $handle ][0];
        $position->[1] = $position->[1] + $directions[ $handle ][1];
    }
    if ( $operation eq q{R} ) {
        $handle = ( $handle + 1 ) % @directions;
    }
}

say join q{ }, @{ $position };

exit;
