#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %links;

for my $a ( @a ) {
    my( $u, $v ) = ( $a, $a + 1 );
    push @{ $links{ $u } }, $v;
    push @{ $links{ $v } }, $u;
}

my %read;
my @candidates = 1 .. $n;
my @answer;

while ( @candidates ) {
    my $v = shift @candidates;
    next
        if $read{ $v }++;
    dfs( $v, undef, \my @chars );
    $read{ $_ }++
        for @chars;
    push @answer, @chars;
}

say join q{ }, @answer;

exit;

sub dfs {
    my $v = shift;
    my $from = shift;
    my $ref = shift;
    for my $w ( grep { !defined $from || $_ != $from } @{ $links{ $v } // [ ] } ) {
        dfs( $w, $v, $ref );
    }
    push @{ $ref }, $v;
    return $ref;
}
