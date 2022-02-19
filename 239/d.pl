#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b, $c, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };

my %is_prime;
$is_prime{ $_ }++
    for grep { is_prime( $_, int( sqrt( $_ ) ) ) } 1 .. 200;

my $aoki_wons = 0;

for my $takahashi ( $a .. $b ) {
    for my $aoki ( $c .. $d ) {
        if ( $is_prime{ $takahashi + $aoki } ) {
            $aoki_wons++;
            last;
        }
    }
}

my $are_all_aoki_won = $aoki_wons == $b - $a + 1;

say $are_all_aoki_won ? "Aoki" : "Takahashi";

exit;

sub is_prime {
    my( $n, $k ) = @_;
    return 1
        if $k == 1;
    return ( ( $n % $k != 0 ) && is_prime( $n, $k - 1 ) );
}
