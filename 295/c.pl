#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %count;
$count{ $_ }++
    for @a;

my $answer = 0;

for my $color ( keys %count ) {
    $answer += int( $count{ $color } / 2 );
}

say $answer;

exit;
