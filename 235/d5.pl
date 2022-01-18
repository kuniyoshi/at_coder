#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $a, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };

my %cost = ( 1 => 0 );
bfs( );

say $cost{ $n } // -1;

exit;

sub bfs {
    my @queue = ( 1 );

    while ( @queue ) {
        my $node = shift @queue;

        if ( !$cost{ $node * $a } && length( $node * $a ) <= length( $n ) ) {
            push @queue, $node * $a;
            $cost{ $node * $a } = $cost{ $node } + 1;
        }

        my @digits = split m{}, $node;

        if ( @digits > 1 && $digits[-1] ) {
            my $value = join q{}, @digits[ -1, 0 .. ( $#digits - 1 ) ];

            if ( !$cost{ $value } ) {
                push @queue, $value;
                $cost{ $value } = $cost{ $node } + 1;
            }
        }
    }
}
