#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{}, $l };

my %count;

for ( my $i = 0; $i < @s; ++$i ) {
    $count{ $s[ $i ] }++;

    if ( %count == 3 ) {
        say $i + 1;
        exit;
    }
}


exit;
