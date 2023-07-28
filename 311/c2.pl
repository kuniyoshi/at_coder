#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %visited;

for my $u ( 1 .. $n ) {
    next
        if $visited{ $u };
    my @vertexes = loop( $u );
    next
        unless @vertexes;

    say scalar @vertexes;
    say join q{ }, @vertexes;
    exit;
}

exit;

sub loop {
    my $u = shift;


}
