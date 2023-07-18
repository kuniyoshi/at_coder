#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $m = int( $n / 2 );

my %u;
my %v;

for ( my $i = 0; $i < ( 1 << $m ); ++$i ) {
    my $bits = $i;
    my $sum = 0;
    my $j = 0;

    while ( $bits ) {
        $sum += $a[ $j ]
            if $bits & 1;
        $j++;
        $bits >>= 1;
    }

    $u{ $sum }++;
}

for ( my $i = 1 << $m; $i < ( 1 << $n ); ++$i ) {
    my $bits = $i;
    my $sum = 0;
    my $j = 0;

    while ( $bits ) {
        $sum += $a[ $j ]
            if $bits & 1;
        $j++;
        $bits >>= 1;
    }

    $v{ $sum }++;
}

for my $u ( keys %u ) {
    my $r = $k - $u;
    if ( $v{ $r } ) {
        say YesNo::get( 1 );
        exit;
    }
}

say YesNo::get( 0 );

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
