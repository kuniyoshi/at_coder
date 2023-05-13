#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum min );

chomp( my $n = <> );
my @s = map { chomp( my $l = <> ); $l }
        1 .. $n;

my $total = sum( map { scalar( () = m{AB}g ) } @s );

my $begin_with_b = grep { m{\A B }msx } @s;
my $end_with_a = grep { m{ A \z}msx } @s;
my $both = grep { m{\A B .* A \z}msx } @s;

my $only_b = $begin_with_b - $both;
my $only_a = $end_with_a - $both;

if ( !$both ) {
    say $total + min( $only_a, $only_b );
    exit;
}

if ( $only_a || $only_b ) {
    say $total + $both + min( $only_a, $only_b );
    exit;
}

say $total + $both - 1;

exit;

__END__
ONLY A  ONLY B  BOTH    TOTAL
10      10      100     60      ->  min(ONLY B, ONLY A) + 
0       20      10      10
10      20      10      20
