#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @pairs = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

my @dp;
$dp[0]++;

for my $i ( 1 .. $n ) {
    my( $a, $b ) = @{ $pairs[ $i - 1 ] };
    my @new_dp = @dp;
    for my $j ( 0 .. $b ) {
        for my $k ( 0 .. $x ) {
            if ( $dp[ $k ] ) {
                $new_dp[ $k + $a * $j ]++;
            }
        }
    }
    $#new_dp = $x;
    @dp = @new_dp;
}

say YesNo::get( $dp[ $x ] );

exit;


use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;


__END__

my @dp;
$dp[0][ $_ ][0]++
    for 0 .. $n;

for my $i ( 1 .. $n ) {
    for my $j ( 0 .. $pairs[ $i - 1 ] ) {

        for my $k ( 0 .. $x ) {
            if ( $dp[ $i - 1 ][ $j ][ $k ] ) {
            }
        }
    }
        for my $k ( 0 .. $x ) {
            if ( $dp[ $i - 1 ][ $j ][ $k ] ) {
                $dp[ $i ][0][ $k ]++;
            }
            if ( $dp[ $i - 1 ][ $j ][ $k ] ) {
                $dp[ $i ][0][ $k ]++;
            }
        }
    }
}

exit;
