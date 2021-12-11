#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $q ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = sort { $a <=> $b }
        do { chomp( my $l = <> ); split m{\s}, $l };
my @x = map { chomp; $_ }
        map { scalar <> }
        1 .. $q;

for my $x ( @x ) {
    if ( $x <= $a[0] ) {
        say scalar @a;
        next;
    }

    if ( $x > $a[-1] ) {
        say 0;
        next;
    }

    my $ac = 0;
    my $wa = $n - 1;

    while ( ( $wa - $ac ) > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );

        if ( $a[ $wj ] >= $x ) {
            $wa = $wj;
        }
        else {
            $ac = $wj;
        }
    }

    say $n - $wa;
}

exit;
