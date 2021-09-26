#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $k = <> );
chomp( my $line = <> );
my( $a, $b ) = split m{\s}, $line;

my $new_a = convert( $a );
my $new_b = convert( $b );

say $new_a * $new_b;

exit;

sub convert {
    my $target = shift;
    my $value = 0;

    my @bits = reverse split m{}, $target;

    for my $index ( 0 .. $#bits ) {
        $value = $value + $k ** $index * $bits[ $index ];
    }

    return $value;
}
