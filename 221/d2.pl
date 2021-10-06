#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @events = sort { $a->[0] <=> $b->[0] }
             map { chomp; my( $x, $y ) = split m{\s}; ( [ $x, 1 ], [ $x + $y, -1 ] ) }
             <>;

my @logins = ( 0 ) x $n;
my $counter = 0;

for ( my $i = 0; $i < @events - 1; ++$i ) {
    my( $day, $type ) = @{ $events[ $i ] };
    $counter = $counter + $type;
    $logins[ $counter - 1 ] = $logins[ $counter - 1 ] + $events[ $i + 1 ][0] - $day;
}

say join q{ }, @logins;

exit;
