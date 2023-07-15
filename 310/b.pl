#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @items = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

my %function;

for my $i ( 0 .. $n - 1 ) {
    my $ref = $items[ $i ];
    for my $j ( 0 .. $ref->[1] - 1 ) {
        $function{ $i }{ $ref->[ 2 + $j ] }++;
    }
}

for my $i ( 0 .. $n - 1 ) {
    for my $j ( 0 .. $n - 1 ) {
        next
            if $i == $j;
        if ( is_prior( $i, $j ) ) {
            say YesNo::get( 1 );
            exit;
        }
    }
}

say YesNo::get( 0 );

exit;

sub is_prior {
    my $a = shift;
    my $b = shift;

    my $a_ref = $items[ $a ];
    my $b_ref = $items[ $b ];

    return
        if $a_ref->[0] > $b_ref->[0];

    return
        if grep { !$function{ $a }{ $_ } } keys %{ $function{ $b } };

    return 1
        if %{ $function{ $a } } > %{ $function{ $b } } || $a_ref->[0] < $b_ref->[0];

    return;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
