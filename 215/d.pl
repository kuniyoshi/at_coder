#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $head_line = <> );
chomp( my $body_line = <> );
my( $n, $m ) = split m{\s}, $head_line;

my @result = ( 1 ) x ( $m + 1 );
$result[0] = 0;

chomp( my @lines = `factor $body_line` );

for my $line ( @lines ) {
    my @factors = split m{\s}, $line;
    shift @factors;

    for my $prime_factor ( @factors ) {
        next
            unless $result[ $prime_factor ];

        for ( my $i = $prime_factor; $i <= @result; $i += $prime_factor ) {
            $result[ $i ] = 0
        }
    }
}

say scalar grep { $_ } @result;
say
    for grep { $result[ $_ ] }
        ( 1 .. $#result );

exit;
