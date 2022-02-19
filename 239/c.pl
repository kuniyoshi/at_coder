#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $x1, $y1, $x2, $y2 ) = do { chomp( my $l = <> ); split m{\s}, $l };

my @positions = (
    [ 1, 2 ],
    [ 2, 1 ],
    [ 2, -1 ],
    [ 1, -2 ],
    [ -1, -2 ],
    [ -2, -1 ],
    [ -2, 1 ],
    [ -1, 2 ],
);

my $x = $x2 - $x1;
my $y = $y2 - $y1;

for my $xy_ref ( @positions ) {
    for my $ref ( get_positions( @{ $xy_ref } ) ) {
        my( $a, $b ) = @{ $ref };
        if ( $a == $x && $b == $y ) {
            say "Yes";
            exit;
        }
    }
}

say "No";

exit;

sub get_positions {
    my( $x, $y ) = @_;
    return map { [ $_->[0] + $x, $_->[1] + $y ] } @positions;
}
