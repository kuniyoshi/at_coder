#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $count = answer( ) // -1;

say $count;

exit;

sub answer {
    my $total = 0;
    my $base;

    my @counts;

    for my $i ( 0 .. $#a ) {
        my $value = $a[ $i ];

        for my $dividor ( 2, 3 ) {
            $counts[ $i ]{ $dividor } = 0;

            while ( ( $value % $dividor ) == 0 ) {
                $value /= $dividor;
                $total++;
                $counts[ $i ]{ $dividor }++;
            }
        }

        if ( !defined $base ) {
            $base = $value;
        }
        elsif ( $value != $base ) {
            return;
        }
    }

    for my $dividor ( 2, 3 ) {
        my $min = min( map { $_->{ $dividor } } @counts );
        $total -= $min * @a;
    }

    return $total;
}
