#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Path::Class qw( file );

my $count = 0;

while ( $count++ < 100 ) {
    my $n = create_n( );
    my @a = create_a( $n );
    my $x = create_x( );

    my $FH = file( "t/data/$count" )->openw;
    say { $FH } $n;
    say { $FH } join q{ }, @a;
    say { $FH } $x;
}


exit;

sub create_x {
    return int( 1e18 * rand ) + 1;
}

sub create_a {
    my $n = shift;
    return map { int( 1e9 * rand ) + 1 } ( 1 .. $n );
}

sub create_n {
    return int( 1e5 * rand ) + 1;
}
