#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = map { $_ + 1e9 }
        do { chomp( my $l = <> ); split m{\s}, $l };
$k = $k + 1e9;

my $acc = 0;
my @acc = ( 0 );

for ( my $i = 0; $i < @a; ++$i ) {
    $acc = $acc + $a[ $i ];
    push @acc, $acc;
}

push @acc, 1e17;

my $total = 0;

for ( my $i = 0; $i < @a; ++$i ) {
    if ( ( $acc[ $i + 1 ] - $acc[ $i ] ) == $k ) {
        $total++;
        next;
    }

    my $ac = $i;
    my $wa = $#acc;
    my $wj = int( ( $ac + $wa ) / 2 );

    if ( $acc[ $wj ] - $acc[ $ac ] 

        next
            if 
    }
}

say $total;

exit;
