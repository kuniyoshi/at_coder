#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

for ( my $i = 1; $i <= $n; ++$i ) {
    if ( $a[0] == $i ) {
        say 0;
        shift @a;
    }
    else {
        say $a[0] - $i;
    }
}

die "remain"
    if @a;

exit;
