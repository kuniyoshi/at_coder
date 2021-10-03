#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );
chomp( my $t = <> );

if ( $t eq $s ) {
    say "Yes";
    exit;
}

my @s_chars = split m{}, $s;
my @t_chars = split m{}, $t;

my @failures = ( );

for ( my $i = 0; $i < @s_chars; ++$i ) {
    push @failures, $i
        if $s_chars[ $i ] ne $t_chars[ $i ];
}

if ( @failures != 2 ) {
    say "No";
    exit;
}

my( $f1, $f2 ) = @failures;
my $delta = abs( $f1 - $f2 );

if ( $delta != 1 ) {
    say "No";
    exit;
}

my $can = $s_chars[ $f1 ] eq $t_chars[ $f2 ]
    && $s_chars[ $f2 ] eq $t_chars[ $f1 ];

say $can ? "Yes" : "No";

exit;
