#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @links = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;

my %connected;

for my $ref ( @links ) {
    my( $a, $b ) = @{ $ref };
    $a--;
    $b--;
    $connected{ $a }{ $b }++;
    $connected{ $b }{ $a }++;
}

my $answer;

for ( my $a = 0; $a < $n; ++$a ) {
    for ( my $b = 0; $b < $n; ++$b ) {
        for ( my $c = 0; $c < $n; ++$c ) {
            if ( $a < $b && $b < $c ) {
                $answer++
                    if $connected{ $a }{ $b } && $connected{ $b }{ $c } && $connected{ $c }{ $a };
            }
        }
    }
}

say $answer // 0;

exit;
