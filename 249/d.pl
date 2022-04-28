#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
@a = sort { $b <=> $a } @a;

my %exists;

my $count = 0;

for my $i ( 0 .. $#a ) {
    for my $j ( $i .. $#a ) {
        my $x = $a[ $i ] * $a[ $j ];
        $count += 2 * ( $exists{ $x } // 0 );
        $count += 2 * ( $exists{ $x } // 0 )
            if $a[ $j ] == 1;
    }

    $exists{ $a[ $i ] }++;
}

say $count;

exit;
