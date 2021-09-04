#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $head = <> );
chomp( my $body = <> );
my( $n, $k ) = split m{\s}, $head;
my @a = sort { $b <=> $a } split m{\s}, $body;

for ( my $i = 0; $i < @a; ++$i ) {
    my $a0 = $a[ $i ];
    my $a1 = $a[ $i + 1 ];
    my $diff = $a1 - $a0;
    $k = $k - $diff;
}

exit;
