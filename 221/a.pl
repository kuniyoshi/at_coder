#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $line = <> );
my( $a, $b ) = split m{\s}, $line;

my $c = $a - $b;

say pow( $c );


exit;

sub pow {
    my $x = shift;

    my $result = 1;
    $result = $result * 32
        while $x--;

    return $result;
}
