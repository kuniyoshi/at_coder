#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @spans = sort { $a->[0] <=> $b->[0] }
            map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

my @finals;

my $left = shift @spans;

while ( @spans ) {
    my $right = shift @spans;

    if ( $right->[0] > $left->[1] ) {
        push @finals, $left;
        $left = $right;
        next;
    }

    $left->[1] = max( $left->[1], $right->[1] );
}

push @finals, $left;

print map { "$_->[0] $_->[1]\n" } @finals;

exit;
