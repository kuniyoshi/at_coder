#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $n = <> );

my @numbers = get_ranks( $n );

for ( my $i = 0; $i < 2 ** @numbers; ++$i ) {
    my @ranks = get_ranks( $i );
    my $number = sum( map { 2 ** $numbers[ $_ ] } @ranks ) // 0;
    printf "%d\n", $number;
}

exit;

sub get_ranks {
    my $number = shift;

    my @digits = reverse split m{}, sprintf "%b", $number;

    return map { $_->[0] }
           grep { $_->[1] }
           map { [ $_, $digits[ $_ ] ]; }
           0 .. $#digits;
}
