#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

$|++;

chomp( my $n = <> );

my @used;
$#used = 2 * $n + 1;
$used[0]++;

while ( 1 ) {
    my $value;

    for my $i ( 1 .. $#used ) {
        if ( !defined $used[ $i ] ) {
            $value = $i;
            $used[ $i ]++;
            last;
        }
    }

    die "un expected"
        unless defined $value;

    say $value;

    chomp( my $aoki = <> );

    if ( $aoki == 0 ) {
        last;
    }

    $used[ $aoki ]++;
}

exit;
