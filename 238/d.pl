#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $t = <> );
my @q = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $t;

for my $q_ref ( @q ) {
    my( $a, $s ) = @{ $q_ref };
    my $has = test( $a, $s, 0 );
    say $has ? "Yes" : "No";
}

exit;

sub test {
    my( $a, $s, $increment ) = @_;
    return 
    my $u = $a & 1;
    my $v = $s & 1;
    for my $x ( 0 .. 1 ) {
        for my $y ( 0 .. 1 ) {
        }
    }
}
