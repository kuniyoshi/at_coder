#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use integer;

chomp( my $n = <> );
chomp( my $line = <> );
my @a = split m{\s}, $line;
chomp( my $x = <> );

my $seriese_sum = sum( @a );
my $seriese_count = $x / $seriese_sum;
my $sum = $seriese_count * $seriese_sum;

my $h = 0;

for my $a ( @a ) {
    $sum = $sum + $a;
    $h++;

    last
        if $sum > $x;
}
$sum = $sum + shift @a
    while $sum < $x;

say $seriese_count * $n + $n - @a;

exit;

sub sum {
    my @numbers = @_;
    my $result = 0;

    $result = $result + shift @numbers
        while @numbers;

    return $result;
}
