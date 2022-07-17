#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $x, $y ) = do { chomp( my $l = <> ); split m{\s}, $l };

say r( $n );

exit;

sub r {
    my $level = shift;
    return 0
        if $level == 1;
    return r( $level - 1 ) + $x * b( $level );
}

sub b {
    my $level = shift;
    return 1
        if $level == 1;
    return r( $level - 1 ) + $y * b( $level - 1 );
}
