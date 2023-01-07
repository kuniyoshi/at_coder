#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $t = <> );

while ( $t-- ) {
    chomp( my $n = <> );
    say join q{ }, solve( $n );
}

exit;

sub solve {
    my $n = shift;
    my %result;
    for ( my $i = 2; $i * $i * $i <= $n; ++$i ) {
        next
            if $n % $i;
        my $a = $n / $i;
        if ( ( $a % $i ) == 0 ) {
            return $i, $a / $i;
        }
        else {
            return int( sqrt( $a ) + 0.5 ), $i;
        }
    }
    die "Could not solve";
}
