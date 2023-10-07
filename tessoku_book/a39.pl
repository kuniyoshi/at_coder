#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $n = <> );
my @ranges = sort { $a->[0] <=> $b->[0] }
             map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. $n;

my $watching_to;
my $watched;

for my $ref ( @ranges ) {
    if ( !defined $watching_to ) {
        $watching_to = $ref->[1];
    }
    elsif ( $watching_to <= $ref->[0] ) {
        $watched++;
        $watching_to = $ref->[1];
    }
    else {
        $watching_to = min( $watching_to, $ref->[1] );
    }
}

$watched++;

say $watched // 0;

exit;
