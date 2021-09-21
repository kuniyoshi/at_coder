#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $x = <> );
chomp( my $n = <> );
my @s = map { chomp( my $l = <> ); $l }
        1 .. $n;

my @new_chars = split m{}, $x;
my %map = map { ( $new_chars[ $_ ] => chr( ord( "a" ) + $_ ) ) } 0 .. $#new_chars;

my @orderables = ( );

for my $s ( @s ) {
    my $new = join q{}, map { $map{ $_ } } split m{}, $s;
    warn "$s -> $new";
    push @orderables, [ $new, $s ];
}

say
    for map { $_->[1] }
        sort { $a->[0] cmp $b->[0] }
        @orderables;


exit;
