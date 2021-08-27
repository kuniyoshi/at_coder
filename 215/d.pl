#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $head_line = <> );
chomp( my $body_line = <> );
my( $n, $m ) = split m{\s}, $head_line;
my @a = split m{\s}, $body_line;

my @b = ( );
$b[ $_ - 1 ]++
    for @a;

my $max = max( @a ) // 0;

my @result = ( 1 ) x $m;

for ( my $i = 2; $i <= $m; ++$i ) {
    my $has;

    for ( my $j = $i; $j <= $max; $j += $i ) {
        next
            unless $b[ $j - 1 ];

        $has++;
        last;
    }

    next
        unless $has;

    for ( my $j = $i; $j <= $m; $j += $i ) {
        $result[ $j - 1 ] = 0;
    }
}

say scalar grep { $_ } @result;
say
    for grep { $result[ $_ - 1 ] }
        ( 1 .. $m );

exit;
