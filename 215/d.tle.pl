#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Memoize;

chomp( my $head_line = <> );
chomp( my $body_line = <> );
my( $n, $m ) = split m{\s}, $head_line;
my @a = split m{\s}, $body_line;

memoize( "gcd" );

my @results = grep { are_all_gcd( \@a, $_ ) }
              ( 1 .. $m );

say scalar @results;
say
    for @results;

exit;

sub are_all_gcd {
    my( $a_ref, $k ) = @_;

    for my $value ( @{ $a_ref } ) {
        my( $smaller, $larger ) = sort { $a <=> $b } ( $value, $k );
        return
            if gcd( $larger, $smaller ) != 1;
    }

    return 1;
}

sub gcd {
    my( $a, $b ) = @_;
    my $r = $a % $b;

    return $b
        if $r == 0;

    return gcd( $b, $r );
}
