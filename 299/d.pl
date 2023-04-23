#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

$|++;

chomp( my $n = <> );

my $zero = 1;
my $one = $n;

while ( abs( $one - $zero ) > 1 ) {
    my $unknown = int( ( $zero + $one ) / 2 );
    say "? $unknown";
    chomp( my $return = <> );
    if ( $return ) {
        $one = $unknown;
    }
    else {
        $zero = $unknown;
    }
}

say "! $zero";

exit;
