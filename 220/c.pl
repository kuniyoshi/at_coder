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
my $seriese_count = int( $x / $seriese_sum );

my $h = 0;
my $sum = $seriese_count * $seriese_sum;

for my $a ( @a ) {
    $sum = $sum + $a;
    $h++;

    last
        if $sum > $x;
}

say $seriese_count * @a + $h;

exit;

sub sum {
    my @numbers = @_;
    my $result = 0;

    for my $number ( @numbers ) {
        $result = $result + $number;
    }

    return $result;
}
