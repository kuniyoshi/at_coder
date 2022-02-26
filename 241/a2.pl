#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $display = 0;

for my $count ( 1 .. 3 ) {
    $display = get_next( $display );
}

say $display;

exit;

sub get_next {
    my $display = shift;
    return $a[ $display ];
}
