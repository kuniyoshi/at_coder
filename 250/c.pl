#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $q ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @x = map { chomp; $_ }
        map { scalar <> }
        1 .. $q;

my @i2v = 1 .. $n;
my @v2i = 0 .. $n - 1;

for my $x ( @x ) {
    #    warn "### $x";
    #    warn Dumper \@i2v;
    #    warn Dumper \@v2i;
    my $value = $x - 1;
    my $index = $v2i[ $value ];
    die "broken: $x should be same as $i2v[ $index ] ($index)"
        if $i2v[ $index ] != $x;
    my $neighbor_index = $index + 1 == $n ? $index - 1 : $index + 1;
    my $neighbor_value = $i2v[ $neighbor_index ] - 1;

    ( $v2i[ $value ], $v2i[ $neighbor_value ] ) = ( $v2i[ $neighbor_value ], $v2i[ $value ] );
    ( $i2v[ $index ], $i2v[ $neighbor_index ] ) = ( $i2v[ $neighbor_index ], $i2v[ $index ] );
}

say join q{ }, @i2v;

exit;
