#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $line = <> );
my( $a, $b, $c ) = split m{\s}, $line;

my $m = 0;

my $max = int( 1000 / $c );

$m++
    while ( !( $m * $c >= $a && $m * $c <= $b ) && $m < $max );

my $value = $m * $c;
say( ( $value >= $a && $value <= $b ) ? $value : -1 );

exit;
__END__
my $min = int( $a / $c );
my $max = int( $b / $c );

my @candidates = ( $min .. $max );
my @multiples = grep { $_ >= $a && $_ <= $b }
                map { $_ * $c }
                @candidates;

say @multiples ? $multiples[0] : -1;

exit;
