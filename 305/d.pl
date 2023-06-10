#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my @sleeps = ( 0 );

for my $i ( 0 .. $n - 1 ) {
    my $acc = $sleeps[-1];
    $acc += $i % 2 ? ( $a[ $i + 1 ] - $a[ $i ] ) : 0;
    push @sleeps, $acc;
}

for my $ref ( @queries ) {
    my( $ql, $qr ) = @{ $ref };
    my $l = bin( $ql );
    my $r = bin( $qr );
    my $slept = $sleeps[ $r ] - $sleeps[ $l ];
    if ( $l % 2 ) {
        $slept -= $ql - $a[ $l ];
    }
    if ( $r % 2 ) {
        $slept += $qr - $a[ $r ];
    }
    say $slept;
}

exit;

sub bin {
    my $value = shift;
    return $n - 1
        if $value == $a[-1];
    my $ac = 0;
    my $wa = $n - 1;
    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $a[ $wj ] <= $value ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }
    return $ac;
}
