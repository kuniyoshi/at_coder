#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min sum );

my @inputs = do { chomp( my $line = <> ); split m{\s}, $line };
my @h = @inputs[ 0 .. 2 ];
my @w = @inputs[ 3 .. 5 ];

my @dp;

for my $i ( 0 .. 2 ) {
    for my $j ( 0 .. 2 ) {
        $dp[ $i ][ $j ] = [ ( 0 ) x 31 ];
    }
}

for my $k ( 1 .. 30 ) {
    if ( $k <= $h[0] - 2 && $k <= $w[0] - 2 ) {
        $dp[0][0][ $k ] = 1;
    }
}

for my $i ( 0 .. 2 ) {
    for my $j ( 0 .. 2 ) {
        next
            if $i + $j == 0;

        for my $k ( 1 .. 30 ) {
            for my $l ( 1 .. $k - 1 ) {
                my @values;

                if ( $i == 0 && $j == 0 ) {
                    die "somehow";
                }
                elsif ( $i == 0 && $j ) {
                    push @values, $dp[ $i ][ $j - 1 ][ $l ]
                        if $l < ( $w[ $j ] + 2 - $j );
                }
                elsif ( $i && $j == 0 ) {
                    push @values, $dp[ $i - 1 ][ $j ][ $l ]
                        if $l < ( $h[ $i ] + 2 - $i );
                }
                else {
                    push @values, $dp[ $i - 1 ][ $j ][ $l ]
                        if $l < ( $h[ $i ] + 2 - $i );
                    push @values, $dp[ $i ][ $j - 1 ][ $l ]
                        if $l < ( $w[ $j ] + 2 - $j );
                }

                unless ( @values ) {
                    #                    $dp[ $i ][ $j ][ $k ] = 1;
                    next;
                }

                #                warn "add($i, $j, $k): ", min( @values );
                $dp[ $i ][ $j ][ $k ] += min( @values );
            }
        }
    }
}

say sum( @{ $dp[2][2] } );

exit;

__END__

a + b + c = h_1
d + e + f = h_2
g + h + i = h_3

a + d + g = w_1
b + e + h = w_2
c + f + i = w_3
