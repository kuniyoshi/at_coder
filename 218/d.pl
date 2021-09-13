#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @vertexes = map {
                   chomp( my $l = <> );
                   [ my( $x, $y ) = split m{\s}, $l ];
               } 1 .. $n;
my %exist = ( );
$exist{ $_->[0] }{ $_->[1] }++
    for @vertexes;

my $result = 0;

for ( my $i = 0; $i < @vertexes; ++$i ) {
    for ( my $j = $i + 1; $j < @vertexes; ++$j ) {
        my $vi = $vertexes[ $i ];
        my $vj = $vertexes[ $j ];

        next
            if $vi->[0] == $vj->[0] || $vi->[1] == $vj->[1];

        my $vk = [ $vj->[0], $vi->[1] ];
        my $vl = [ $vi->[0], $vj->[1] ];

        next
            unless $exist{ $vk->[0] }{ $vk->[1] };
        next
            unless $exist{ $vl->[0] }{ $vl->[1] };

        $result++;
    }
}

say $result / 2;

exit;
