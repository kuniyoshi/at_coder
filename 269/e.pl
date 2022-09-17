#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );

my @fixed = (
    [ build( 2, 1, 2, 1 ), build2( 1, $n ) ],
    [ build( 1, 2, 1, 2 ), build2( $n, 1 ) ],

    [ build( $n - 1, 1, $n - 1, 1 ), build2( 1, $n ) ],
    [ build( $n, 1, $n, 1 ), build2( 1, 1 ) ],

    [ build( ), build2( 1, $n ) ],
    [ build( $n, 1, $n, 1 ), build2( 1, 1 ) ],

    [ "? 1 2 1 2", "! $n 1" ],
    [ "? 1 2 1 2", "! $n 1" ],

    [ "? 1 2 1 2", "! $n 1" ],
    [ "? 1 2 1 2", "! $n 1" ],
);

for my $ref ( @fixed ) {
    my $answer = query( $ref->[0] );

    if ( $answer == 1 ) {
        say $ref->[1];
        exit;
    }
}




exit;

sub build {
    my @numbers = @_;
    return sprintf "? %s", join q{ }, @numbers;
}

sub build2 {
    my @numbers = @_;
    return sprintf "! %s", join q{ }, @numbers;
}

sub query {
    my $q = shift;
    say $q;
    chomp( my $answer = <> );
    die "failure"
        if $answer == -1;
    return $answer;
}
