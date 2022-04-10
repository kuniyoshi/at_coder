#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @names = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

for my $i ( 0 .. $n - 1 ) {
    my @cans = ( 1 ) x 2;

    for my $k ( 0 .. 1 ) {
        my $nickname = $names[ $i ][ $k ];

        for my $j ( 0 .. $n - 1 ) {
            next
                if $i == $j;

            undef $cans[ $k ]
                if $names[ $j ][0] eq $nickname or $names[ $j ][1] eq $nickname;
        }
    }

    if ( !grep { defined } @cans ) {
        say "No";
        exit;
    }
}

say "Yes";

exit;
