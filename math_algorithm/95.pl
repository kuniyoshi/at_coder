#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @scores = map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. $n;
chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my @accs = ( [ 0 ], [ 0 ] );

for my $ref ( @scores ) {
    my( $class, $score ) = @{ $ref };
    $class--;

    for my $i ( 0 .. 1 ) {
        my $add = $i == $class ? $score : 0;
        push @{ $accs[ $i ] }, $accs[ $i ][-1] + $add;
    }
}

for my $ref ( @queries ) {
    my( $from, $to ) = @{ $ref };
    say join q{ }, map { $accs[ $_ ][ $to ] - $accs[ $_ ][ $from - 1 ] } 0 .. 1;
}


exit;

