#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @c = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

say join q{ }, map { my $j = $_; sum( map { $c[ $_ ][ $j ] eq q{#} } 0 .. $h - 1 ) } 0 .. $w - 1;

exit;
