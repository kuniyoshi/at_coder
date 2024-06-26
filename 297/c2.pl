#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; $_ }
        map { scalar <> }
        1 .. $h;

for my $s ( @s ) {
    $s =~ s{TT}{PC}g;
    say $s;
}

exit;

