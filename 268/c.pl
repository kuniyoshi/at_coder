#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @p = do { chomp( my $l = <> ); split m{\s}, $l };

my @turns;

for ( my $i = 0; $i < @p; ++$i ) {
    my $person = $i;
    my $dish = $p[ $i ];
    my $just = $person >= $dish ? ( $person - $dish ) : ( $n + $person - $dish );
    die "invalid just: $just"
        if $just < 0 || $just >= $n;
    my $j1 = ( $just + 1 ) == $n ? 0 : $just + 1;
    my $j2 = ( $just - 1 ) < 0 ? $n - 1 : $just - 1;
    $turns[ $just ]++;
    $turns[ $j1 ]++;
    $turns[ $j2 ]++;
}

$_ //= 0
    for @turns;

say max( @turns );

exit;

__END__
[0,0]
[0,1]
[1,3]
[2,4]
[2,4]
[3,5]

[0,1)
[0,2)
[1,4)
[2,5)
[2,5)
[3,6)
