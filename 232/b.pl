#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );
chomp( my $t = <> );

my @s = split m{}, $s;
my @t = split m{}, $t;

my @chars = ( "a" .. "z" ) x 2;
my $diff = ord( $t[0] ) - ord( $s[0] );

for ( my $i = 0; $i < @s; ++$i ) {
    my $char_index = ord( $s[ $i ] ) - ord( "a" );
    if ( $t[ $i ] ne $chars[ $char_index + $diff ] ) {
        say "No";
        exit;
    }
}

say "Yes";

exit;
