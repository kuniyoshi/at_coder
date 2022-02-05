#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @degrees = ( 0 );

my $acc = 0;

for my $a ( @a ) {
    $acc = ( $acc + $a ) % 360;
    push @degrees, $acc;
}

@degrees = sort { $a <=> $b } @degrees;

my $max = 0;

for ( my $i = 0; $i < 2 * @degrees; ++$i ) {
    my $l = $degrees[ $i % @degrees ];
    my $r = $degrees[ ( $i + 1 ) % @degrees ];
    my $degree = $r > $l ? $r - $l : ( $r + 360 ) - $l;
    $max = $degree > $max ? $degree : $max;
}

say $max;

exit;
