#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $q ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @x = map { chomp( my $l = <> ); $l }
        1 .. $q;

@a = sort { $a <=> $b } @a;

my @acc;
my $acc = 0;
push @acc, $acc;

for my $a ( @a ) {
    $acc += $a;
    push @acc, $acc;
}

for my $x ( @x ) {
    if ( $x <= $a[0] ) {
        say $acc[-1] - $x * $n;
        next;
    }

    if ( $x >= $a[-1] ) {
        say $x * $n - $acc[-1];
        next;
    }

    my $ac = 0;
    my $wa = $#a;

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $a[ $wj ] < $x ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    #warn Dumper \@a;
    #warn Dumper \@acc;
    #warn "\$ac: $ac";
    #warn "\$wa: $wa";

    my $left = $x * ( $ac + 1 ) - $acc[ $ac + 1 ];
    my $right = $acc[-1] - $acc[ $ac + 1 ] - $x * ( $n - $ac - 1 );
    #warn "\$left: $left";
    #warn "\$right: $right";

    say $x * ( $ac + 1 ) - $acc[ $ac + 1 ]
        + $acc[-1] - $acc[ $ac + 1 ] - $x * ( $n - $ac - 1 );

        #last;
}

exit;
