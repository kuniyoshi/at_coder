#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $s = <> );

my @chars = split m{}, $s;

my $is_in;

for my $i ( 0 .. $#chars ) {
    if ( $chars[ $i ] eq q{"} ) {
        $is_in = !$is_in;
        next;
    }

    if ( !$is_in && $chars[ $i ] eq q{,} ) {
        $chars[ $i ] = q{.};
    }
}

say join q{}, @chars;


exit;
