#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @sets;

my $remain = $m;

while ( $remain-- ) {
    chomp( my $unuse = <> );
    my @a = do { chomp( my $l = <> ); split m{\s}, $l };
    my $bits = 0;
    $bits |= 1 << ($_ - 1 )
        for @a;
    push @sets, $bits;
}

my $answer = 0;

OUTER:
for my $i ( 0 .. ( 2 ** $m - 1 ) ) {
    my @bits = reverse split m{}, sprintf "%b", $i;
    my @selections = grep { $bits[ $_ ] } 0 .. $#bits;
    my $bits = 0;
    $bits |= $_
        for @sets[ @selections ];
    if ( $bits == ( 1 << $n ) - 1 ) {
        $answer++;
    }
}

say $answer;

exit;
