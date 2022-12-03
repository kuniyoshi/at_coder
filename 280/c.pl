#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };
my @t = do { chomp( my $l = <> ); split m{}, $l };

say find( );

exit;

sub find {
    for ( my $i = 0; $i < @s; ++$i ) {
        if ( $t[ $i ] ne $s[ $i ] ) {
            return $i + 1;
        }
    }

    return scalar @t;
}
