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

die "invalid n"
    unless @s == $n;

my @new_chars = split m{}, $x;
die "invalid x"
    unless @new_chars == 26;

my @new_names = ( );

for my $s ( @s ) {
    for my $c ( split m{}, $s ) {
        die "invalid index"
            unless defined $new_chars[ ord( $c ) - ord( "a" ) ];
    }
    my $new_name = join q{}, map { $new_chars[ ord( $_ ) - ord( "a" ) ] } split m{}, $s;
    die "invalid length"
        unless length( $new_name ) == length( $s );
    push @new_names, [ $new_name, $s ];
}

die "invalid n"
    unless @new_names == $n;

say $_
    for map { $_->[1] }
        sort { $a->[0] cmp $b->[0] }
        @new_names;


exit;
