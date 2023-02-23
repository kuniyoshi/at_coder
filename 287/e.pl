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

my %trie;

for my $s_ref ( @s ) {
    my @chars = @{ $s_ref };
    r( \@chars, \%trie );
}

for my $s_ref ( @s ) {
    say count( 0, $s_ref, \%trie );
}

exit;

sub count {
    my $depth = shift;
    my $chars_ref = shift;
    my $tree_ref = shift;

    if ( !%{ $tree_ref } ) {
        return 0;
    }

    if ( %{ $tree_ref } == 1 ||
}

sub r {
    my $chars_ref = shift;
    my $tree_ref = shift;
    $tree_ref->{__count}++;
    if ( !@{ $chars_ref } ) {
        return;
    }
    my $char = shift @{ $chars_ref };
    warn "\$char: $char";
    $tree_ref->{ $char } //= { };
    r( $chars_ref, $tree_ref->{ $char } );
}
