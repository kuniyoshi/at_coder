#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $h;

my @chars = ( q{.}, q{A} .. q{Z} );

say join q{}, map { $chars[ $_ ] } @{ $_ } for @a;

exit;
