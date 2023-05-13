#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{\s}, $l };

my @result;

for ( my $i = 0; $i < @s - 1; ++$i ) {
    my $is_ascend = $s[ $i ] < $s[ $i + 1 ];
    my( $l, $r ) = @s[ $i, $i + 1 ];
    push @result, ( $is_ascend ? ( $l .. ( $r - 1 ) ) : reverse( ( $r + 1 ) .. $l ) );
}

say join q{ }, ( @result, $s[-1] );

exit;
