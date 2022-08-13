#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $r, $c ) = do { chomp( my $l = <> ); split m{\s}, $l };

my @whiltes = ( [ 8, 8 ] );
push @whiltes, map { [ $_, 6 ] } 6 .. 10;
push @whiltes, map { [ $_, 10 ] } 6 .. 10;
push @whiltes, map { [ 6, $_ ] } 6 .. 10;
push @whiltes, map { [ 10, $_ ] } 6 .. 10;
push @whiltes, map { [ $_, 4 ] } 4 .. 12;
push @whiltes, map { [ $_, 12 ] } 4 .. 12;
push @whiltes, map { [ 4, $_ ] } 4 .. 12;
push @whiltes, map { [ 12, $_ ] } 4 .. 12;
push @whiltes, map { [ $_, 2 ] } 2 .. 14;
push @whiltes, map { [ $_, 14 ] } 2 .. 14;
push @whiltes, map { [ 2, $_ ] } 2 .. 14;
push @whiltes, map { [ 14, $_ ] } 2 .. 14;

#for my $i ( 1 .. 15 ) {
#    for my $j ( 1 .. 15 ) {
#        my $is_white = grep { $_->[0] == $i && $_->[1] == $j } @whiltes;
#        print $is_white ? q{ } : q{#};
#    }
#    print "\n";
#}

my $is_white = grep { $_->[0] == $r && $_->[1] == $c } @whiltes;

say $is_white ? "white" : "black";


exit;
