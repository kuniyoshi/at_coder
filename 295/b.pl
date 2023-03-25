#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $r, $c ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $r;

my @result = map { [ @{ $_ } ] } @b;

for my $row ( 0 .. $r - 1 ) {
    for my $col ( 0 .. $c - 1 ) {
        next
            if $b[ $row ][ $col ] eq q{#} || $b[ $row ][ $col ] eq q{.};

        bomb( $row, $col, $b[ $row ][ $col ] );
    }
}

say join qq{\n}, map { join q{}, @{ $_ } } @result;


exit;

sub bomb {
    my( $row, $col, $power ) = @_;

    for my $ri ( $row - $power .. $row + $power ) {
        for my $ci ( $col - $power .. $col + $power ) {
            next
                if $ri < 0 || $ri >= $r || $ci < 0 || $ci >= $c;
            next
                if ( ( abs( $row - $ri ) + abs( $col - $ci ) ) > $power );
            $result[ $ri ][ $ci ] = q{.};
        }
    }
}
