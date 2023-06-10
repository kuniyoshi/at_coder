#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $p, $q ) = do { chomp( my $l = <> ); split m{\s}, $l };

my %distance = (
    A => 0,
    B => 3,
    C => 4,
    D => 8,
    E => 9,
    F => 14,
    G => 23,
);

#for my $c ( "B" .. "G" ) {
#    my $b = chr( ord( $c ) - 1 );
#    say $distance{ $c } - $distance{ $b };
#}

say abs( $distance{ $q } - $distance{ $p } );

exit;
