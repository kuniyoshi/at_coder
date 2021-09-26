#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $n = <> );
chomp( my $line = <> );
my @a = split m{\s}, $line;
chomp( my $x = <> );

my $seriese_sum = sum @a;
my $seriese_count = int( $x / $seriese_sum );
my $sum = $seriese_count * $seriese_sum;

while ( $sum < $x ) {
    die "xx"
        unless @a;
    $sum = $sum + shift @a;
}

say $seriese_count * $n + $n - @a;

exit;
