#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{\s}, $l };

my @collections = sort { $a <=> $b } @s;

my @volums;
my $duplicates = 0;
my $previous = undef;

for my $i ( 0 .. $#collections ) {
    if ( defined $previous && $collections[ $i ] == $previous ) {
        $duplicates++;
        next;
    }

    push @volums, $collections[ $i ];
    $previous = $volums[-1];
}

push @volums, 1e9 + 1
    for 1 .. $duplicates;

my $read = 0;

while ( @volums ) {
    my $want = $read + 1;

    if ( $volums[0] == $want ) {
        shift @volums;
        $read++;
        next;
    }

    last
        if @volums < 2;

    pop @volums
        for 1 .. 2;

    unshift @volums, $read + 1;
}

say $read;

exit;
