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

warn "($only_a, $only_b, $both)";
$total += 2 * simulate( \$both, \$only_a, \$only_b );

warn "($only_a, $only_b, $both)";
my $z = min( min( $only_a, $both ), min( $only_b, $both ) );
$total += 2 * $z;
$only_a -= $z;
$both -= 2 * $z;

warn "($only_a, $only_b, $both)";
$total += simulate( \$only_b, \$only_a );

warn "($only_a, $only_b, $both)";
$total += simulate( \$only_a, \$both );

warn "($only_a, $only_b, $both)";
$total += simulate( \$only_b, \$both );

my $x = int( $both / 2 );
$total += $x;
$both -= $x;

warn "finally: ($only_a, $only_b, $both)";
say $total;

exit;

sub simulate {
    my @values = @_;
    my $min = min( map { $$_ } @values );
    $$_ -= $min
        for @values;
    return $min;
}

__END__
ONLY A  ONLY B  BOTH    TOTAL
10      10      100     60      ->  min(ONLY B, ONLY A) + 
0       20      10      10
10      20      10      20
