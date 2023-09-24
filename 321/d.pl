#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m, $p ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = sort { $a <=> $b } do { chomp( my $l = <> ); split m{\s}, $l };

my $acc = 0;
my @acc = ( 0 );

for my $b ( @b ) {
    push @acc, ( $acc += $b );
}

#warn Dumper \@b;

#warn Dumper [ map { $_ + $a[0] } @b ];

my $global_total = 0;

for my $a ( @a ) {
    my $index = bin( $a );
    #warn "$a: \$index: $index";
    my $total = 0;

    if ( !defined $index ) {
        $total = $a * $m + $acc[-1];
    }
    elsif ( $index == 0 ) {
        $total = $p * $m;
    }
    else {
        $total = $a * $index + $acc[ $index ] + $p * ( $m - $index );
    }

    #    warn "\$total: $total";
    $global_total += $total;
}

say $global_total;

exit;

# find min p index
sub bin {
    my $a = shift;
    return
        if $a + $b[-1] <= $p;
    return 0
        if $a + $b[0] >= $p;

    my $ac = $#b;
    my $wa = 0;

    while ( $ac - $wa > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $a + $b[ $wj ] >= $p ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    return $ac;
}
