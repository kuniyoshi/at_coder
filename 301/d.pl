#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };
chomp( my $n = <> );

my $min = to_digit( join q{}, map { m{[?]} ? 0 : $_ } @s );
my $max = to_digit( join q{}, map { m{[?]} ? 1 : $_ } @s );

if ( $min > $n ) {
    say -1;
    exit;
}

if ( $max <= $n ) {
    say $max;
    exit;
}

my( $ac, $wa ) = ( $min, $n );

use bigint;

while ( $wa - $ac > 1 ) {
    my $wj = int( ( $wa + $ac ) / 2 );
    warn "($ac, $wa) -> $wj";
    if ( f( $wj ) ) {
        $ac = $wj;
    } else {
        $wa = $wj;
    }
}

say $ac;

exit;

sub f {
    my @wj = split m{}, sprintf "%b", shift;
    warn Dumper \@wj;
    my @t = @{ [ reverse @s ] }[ 0 .. $#wj ];

    for ( my $i = 0; $i < @wj; ++$i ) {
        return 1
            if !$wj[ $i ] && $t[ $i ] ne q{0};
        next
            if $wj[ $i ] eq q{0} && $t[ $i ] eq q{0};
        return
            if $wj[ $i ] && $t[ $i ] eq q{0};
    }

    return 1;
}

sub to_digit {
    my $s = shift;
    my @bits = split m{}, $s;
    my $value = 0;
    my $kata = 0;
    while ( @bits ) {
        my $bit = pop @bits;
        if ( $bit ) {
            $value += 2 ** $kata;
        }
        $kata++;
    }
    return $value;
}
