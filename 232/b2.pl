#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { $_ = <>; chomp; split m{} };
my @t = do { $_ = <>; chomp; split m{} };

K_LOOP:
for my $k ( 0 .. 25 ) {
    for ( my $i = 0; $i < @s; ++$i ) {
        my $s = ord( $s[ $i ] ) - ord( "a" );
        my $t = ord( $t[ $i ] ) - ord( "a" );

        next K_LOOP
            if ( ( $s + $k ) % 26 ) != $t;
    }

    say "Yes";
    exit;
}

say "No";

exit;

