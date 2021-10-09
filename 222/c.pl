#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $head = <> );
my( $n, $m ) = split m{\s}, $head;
my @janken = map { chomp( my $line = <> ); { id => $_, wins => 0, patterns => [ split m{}, $line ] } }
             1 .. 2 * $n;

my %win = (
    G => { C => 1 },
    C => { P => 1 },
    P => { G => 1 },
);

for my $i ( 1 .. $m ) {
    for my $j ( 1 .. $n ) {
        my $x = $janken[ 2 * $j - 1 - 1 ];
        my $y = $janken[ 2 * $j - 1 ];

        my $v = $x->{patterns}[ $i - 1 ];
        my $w = $y->{patterns}[ $i - 1 ];

        $x->{wins} += $win{ $v }{ $w } // 0;
        $y->{wins} += $win{ $w }{ $v } // 0;
    }

    @janken = sort { $b->{wins} <=> $a->{wins} }
              sort { $a->{id} <=> $b->{id} }
              @janken;
}

say $_->{id}
    for @janken;

exit;
