#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @inputs = do { chomp( my $line = <> ); split m{\s}, $line };
my @h = @inputs[ 0 .. 2 ];
my @w = @inputs[ 3 .. 5 ];

my $count = 0;

for my $a ( 1 .. 30 ) {
    for my $b ( 1 .. 30 ) {
        for my $c ( 1 .. 30 ) {
            for my $d ( 1 .. 30 ) {
                my $v = $h[0] - ( $a + $b );
                my $w = $h[1] - ( $c + $d );
                my $x = $w[0] - ( $a + $c );
                my $y = $w[1] - ( $b + $d );
                my $z1 = $h[2] - ( $x + $y );
                my $z2 = $w[2] - ( $v + $w );

                next
                    if $z2 != $z1;

                my $z = $z1;

                next
                    if grep { $_ <= 0 } ( $v, $w, $x, $y, $z );

                $count++;
            }
        }
    }
}

say $count;

exit;
