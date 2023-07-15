#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

my %set;

for my $ref ( @s ) {
    my $s = join( q{}, @{ $ref } );
    my $r = join( q{}, reverse @{ $ref } );

    next
        if $set{ $s } || $set{ $r };


    $set{ $s }++;
}

say scalar %set;

exit;
