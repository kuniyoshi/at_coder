#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $head = <> );
my( $l, $q ) = split m{\s}, $head;
my @q = map { chomp( my $line = <> ); [ split m{\s}, $line ] }
        1 .. $q;

my @cuts = ( 0, $l );

for my $query ( @q ) {
    my( $operation, $x ) = @{ $query };
    if ( $operation == 2 ) {
        my $left = 0;
        my $right = $#cuts;

        while ( $left < $right ) {
            my $center = $left + int( ( $right - $left ) / 2 );

            if ( $x > $cuts[ $center ] ) {
                $left = $center + 1;
            }

            if ( $x < $cuts[ $center ] ) {
                $right = $center;
            }
        }
        $left--
            if $x < $cuts[ $left ];
        say $cuts[ $left + 1 ] - $cuts[ $left ];
    }
    if ( $operation == 1 ) {
        push @cuts, $x;
        @cuts = sort { $a <=> $b } @cuts;
    }
}

exit;
