#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $s = <> );

for ( my $i = 0; $i < $n - 2; ++$i ) {
    if ( substr( $s, $i, 3 ) eq q{ABC} ) {
        say $i + 1;
        exit;
    }
}

say -1;

exit;
