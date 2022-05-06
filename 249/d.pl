#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
@a = sort { $a <=> $b } @a;

my %exists;
$exists{ $_ }++
    for @a;

my $count = 0;

for my $i ( 0 .. $#a ) {
    for my $j ( $i .. $#a ) {
        warn "($i, $j)";
        my $x = $a[ $i ] * $a[ $j ];
        warn "\$x: $x";
        last
            if $x > $a[-1];
        next
            unless defined $exists{ $x };
        $count += $exists{ $a[ $i ] } * $exists{ $a[ $j ] };# * $exists{ $x };
    }
    #    $exists{ $a[ $i ] }++;
}

say $count;

exit;
