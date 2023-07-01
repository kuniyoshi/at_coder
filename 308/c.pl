#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use integer;

chomp( my $n = <> );
my @ab = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $n;

my @indexes = map { $_->[0] }
    sort {
    my( $a1, $b1 ) = @{ $a->[1] };
    my( $a2, $b2 ) = @{ $b->[1] };

    my $r = $a2 * ( $a1 + $b1 ) - $a1 * ( $a2 + $b2 );
    warn "($a->[0], $b->[0]) \$r: $r";
    $r;
    #$b->[1][0] * ( $a->[1][0] + $a->[1][1] ) - $a->[1][0] * ( $b->[1][0] + $b->[1][1] )
    }
              map { [ $_, $ab[ $_ ] ] }
              0 .. $#ab;

say join q{ }, map { $_ + 1 } @indexes;

exit;
