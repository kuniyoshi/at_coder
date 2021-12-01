#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @numbers = ( 1 .. 10 );

my $ac = 0;
my $wa = $#numbers;

while ( $wa - $ac > 1 ) {
    my $wj = int( ( $ac + $wa ) / 2 );

    if ( $numbers[ $wj ] < 5 ) {
        $ac = $wj;
    }
    else {
        $wa = $wj;
    }
}

say "$ac, $numbers[ $ac ]";


exit;

