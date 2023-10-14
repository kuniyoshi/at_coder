#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
chomp( my $s = <> );
#my @s = do { chomp( my $l = <> ); split m{\s}, $l };

my $upper = sqrt( 10 ** $n );
my $count = 0;
my %frequency;
$frequency{ $_ }++
    for split m{}, $s;

LOOP:
for ( my $i = 0; $i < $upper; ++$i ) {
    my %candidate;
    $candidate{ $_ }++
        for split m{}, ( $i * $i );

    $candidate{0} += max( $n - length( $i * $i ), 0 );

    for my $number ( 0 .. 9 ) {
        next LOOP
            if ( ( $candidate{ $number } // 0 ) != ( $frequency{ $number } // 0 ) );
    }

    $count++;
}

say $count;

exit;
