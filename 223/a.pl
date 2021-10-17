#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $x = <> );

if ( $x == 0 ) {
    say "No";
    exit;
}

my $n = int( $x / 100 );
my $is = $n * 100 == $x;
say $is ? "Yes" : "No";


exit;
