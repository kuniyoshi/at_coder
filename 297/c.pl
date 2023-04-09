#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

my $count;

for my $ref ( @s ) {
    for my $i ( 0 .. $w - 2 ) {
        if ( $ref->[ $i ] eq q{T} && $ref->[ $i + 1 ] eq q{T} ) {
            $ref->[ $i ] = q{P};
            $ref->[ $i + 1 ] = q{C};
        }
    }
}

print map { $_, "\n" } map { join q{}, @{ $_ } } @s;

exit;
